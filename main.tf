resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "kubernetes_namespace" "dev" {
  metadata {
    name = "dev"
  }
}

resource "kubernetes_namespace" "uat" {
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
  namespace = "argocd"
  repository = "https://github.com/leolee-rac/argocd-poc.git"
  chart      = "charts/argo-cd"
  # depends_on = [
  #   kubernetes_namespace.argocd
  # ]
  values = [
    file("ha-install.yaml")
  ]
  # set {
  #   name  = "server.service.type"
  #   value = "LoadBalancer"
  # }
}

resource "helm_release" "argocd-manager" {
  name       = "argocd-manager"
  namespace = "argocd"
  repository = "https://github.com/leolee-rac/argocd-poc.git"
  chart      = "charts/root-app"
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

#helm status argocd --namespace argocd
#helm install argocd argo/argo-cd --namespace argocd --create-namespace -f ha-install.yaml
#helm install  argocd charts/argo-cd/ -f ha-install.yaml --dry-run --debug -n default --version 7.0.0
#helm upgrade argocd charts/argo-cd/ -f ha-install.yaml -n default --version 7.0.0 --force
#helm uninstall argocd --namespace argocd
#helm install -f values-dev.yaml root-app ./charts/root-app
#helm list -n argocd
#helm list -A
#helm uninstall applicationset -n argocd

#helm repo remove argo
#helm repo add argo https://argoproj.github.io/argo-helm
#helm repo update
#helm search repo argo/argo-cd --versions

#kubectl delete clusterrole argocd-application-controller
#kubectl delete clusterrole argocd-server
#terraform plan -out main.tfplan
#terraform apply main.tfplan

#terraform state list
#terraform state rm helm_release.applicationset

#kubectl annotate serviceaccount argocd-application-controller -n argocd meta.helm.sh/release-name=argocd --overwrite
#kubectl annotate serviceaccount argocd-application-controller -n argocd meta.helm.sh/release-namespace=default --overwrite

#kubectl annotate serviceaccount argocd-server -n argocd meta.helm.sh/release-name=argocd --overwrite
#kubectl annotate serviceaccount argocd-server -n argocd meta.helm.sh/release-namespace=argocd --overwrite

#kubectl annotate secret argocd-secret -n argocd meta.helm.sh/release-name=argocd --overwrite
#kubectl annotate secret argocd-secret -n argocd meta.helm.sh/release-namespace=argocd --overwrite

#kubectl annotate crd applications.argoproj.io meta.helm.sh/release-namespace=default --overwrite
#kubectl annotate crd applicationsets.argoproj.io meta.helm.sh/release-namespace=default --overwrite
#kubectl annotate crd appprojects.argoproj.io meta.helm.sh/release-namespace=default --overwrite

# kubectl annotate crd applications.argoproj.io meta.helm.sh/release-name=argo-cd --overwrite
# kubectl annotate crd applicationsets.argoproj.io meta.helm.sh/release-name=argo-cd --overwrite
# kubectl annotate crd appprojects.argoproj.io meta.helm.sh/release-name=argo-cd --overwrite

# or
# kubectl delete crd applications.argoproj.io
# kubectl delete crd applicationsets.argoproj.io
# kubectl delete crd appprojects.argoproj.io


#kubectl get namespaces
#kubectl -n argocd rollout restart deployment argocd-server


#kubectl edit application guestbook --namespace default
#kubectl apply -n argocd -f applicationset.yaml
#kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/applicationset/v0.4.0/manifests/install.yaml

# upgrade https://www.arthurkoziel.com/setting-up-argocd-with-helm/
# helm dep update charts/argo-cd/