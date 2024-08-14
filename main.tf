resource "kubernetes_namespace" "argocd" {
  depends_on = [data.azurerm_kubernetes_cluster.aks2]

  metadata {
    name = "argocd"
  }
}

resource "kubernetes_namespace" "dev" {
  depends_on = [data.azurerm_kubernetes_cluster.aks2]

  metadata {
    name = "dev"
  }
}

resource "kubernetes_namespace" "uat" {
  depends_on = [data.azurerm_kubernetes_cluster.aks2]

  metadata {
    name = "uat"
  }
}

# Auth to fetch git-ops code
# resource "kubernetes_secret" "argocd_repo_credentials" {
#   depends_on = [kubernetes_namespace.argocd]
#   metadata {
#     name      = "argocd-repo-credentials"
#     namespace = "argocd"
#     labels = merge(local.argocd_resources_labels, {
#       "argocd.argoproj.io/secret-type" = "repo-creds"
#     })
#     annotations = local.argocd_resources_annotations
#   }
#   type = "Opaque"

# }





# https://github.com/argoproj/argo-helm/blob/main/charts/argo-cd/README.md
resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = "argocd"
  create_namespace = true
  //repository = "file://C:/Dev/repo/applications/"
  chart      = "./charts/argo-cd"
  render_subchart_notes = false
  depends_on = [data.azurerm_kubernetes_cluster.aks2]
  values = [
    file("ha-install.yaml")
  ]
  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }

}

resource "helm_release" "guestbook" {
  name       = "guestbook"
  namespace  = "argocd"
  create_namespace = true
  //repository = "file://C:/Dev/repo/applications/root-app"
  chart      = "./charts/root-app"
  render_subchart_notes = false
  depends_on = [helm_release.argocd]

}




# replace with code?
# resource "argocd_cluster" "argocd_cluster_aks2" {
#   depends_on = [helm_release.argocd]
#   name      = data.azurerm_kubernetes_cluster.aks2.name
#   server     = data.azurerm_kubernetes_cluster.aks2.kube_config[0].host
#   namespaces = ["default", "argocd"]

#   config {
#     tls_client_config {
#       #ca_data = base64decode(data.azurerm_kubernetes_cluster.aks2.kube_config[0].cluster_ca_certificate)
#       cert_data = base64decode(data.azurerm_kubernetes_cluster.aks2.kube_config[0].client_certificate)
#       key_data = base64decode(data.azurerm_kubernetes_cluster.aks2.kube_config[0].client_key)
#       insecure = true
#     }
#   }
# }

# resource "null_resource" "add_cluster_npe" {
#   provisioner "local-exec" {
#     command = "argocd cluster add shield-v19-npe"
#   }

#   depends_on = [
#     helm_release.argocd  # Make sure to depend on the config map change
#   ]
# }

# resource "null_resource" "install_argocd" {
#   provisioner "local-exec" {
#     command = "kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/master/manifests/ha/install.yaml"
#   }
# }

# resource "kubernetes_config_map" "argocd_cmd_params" {
#   depends_on = [helm_release.argocd]
#   metadata {
#     name      = "argocd-cmd-params-cm"
#     namespace = "argocd"
#   }

#   data = {
#     "applicationsetcontroller.enable.progressive.syncs" = "true"
#   }
# }



# resource "null_resource" "restart_argocd_controller" {
#   depends_on = [
#     kubernetes_config_map.argocd_cmd_params  # Make sure to depend on the config map change
#   ]
#   provisioner "local-exec" {
#     command = "kubectl rollout restart deployment argocd-application-controller -n argocd"
#   }


# }


# resource "kubernetes_secret" "argocd_cluster_aks1" {
#   depends_on = [helm_release.argocd]
#   metadata {
#     name      = data.azurerm_kubernetes_cluster.aks1.name
#     namespace = "argocd"

#     labels = {
#       "argocd.argoproj.io/secret-type" = "cluster"
#     }
#   }

#   data = {
#     name            = base64encode(data.azurerm_kubernetes_cluster.aks2.name)
#     server          = base64encode(data.azurerm_kubernetes_cluster.aks2.kube_config.0.host)
#     clusterResources = true
#     config          = base64encode(jsonencode({
#       tlsClientConfig = {
#         insecure = true
#         #caData = data.azurerm_kubernetes_cluster.aks2.kube_config.0.cluster_ca_certificate
#         cert_data = base64decode(data.azurerm_kubernetes_cluster.aks2.kube_config[0].client_certificate)
#         key_data = base64decode(data.azurerm_kubernetes_cluster.aks2.kube_config[0].client_key)
#       }
#     }))
#   }
# }
/*
resource "kubectl_manifest" "guestbook" {
  depends_on = [helm_release.argocd]

  yaml_body = yamlencode({
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
      name      = "guestbook"
      namespace = "argocd"
    }

    spec = {
      project = "default"
      source = {
        repoURL = "https://github.com/argoproj/argocd-example-apps.git"
        path = "guestbook"
      }
      destination = {
        namespace = "default"
        server = "https://kubernetes.default.svc"
      }
      syncPolicy = {
        automated = {
          prune = true
          selfHeal = true
        }
      }
    }
  })

}
*/
#helm status argocd --namespace argocd
#helm install argocd argo/argo-cd --namespace argocd --create-namespace -f ha-install.yaml
#helm uninstall argocd --namespace argocd
#kubectl delete clusterrole argocd-application-controller
#kubectl delete clusterrole argocd-server
#terraform plan -out main.tfplan
#terraform apply main.tfplan