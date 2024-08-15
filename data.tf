# locals {
#   infra_rg_name       = var.rg_name_aks1
#   argocd_resources_labels = {
#     "app.kubernetes.io/instance"  = "argocd"
#     "argocd.argoproj.io/instance" = "argocd"
#   }

#   argocd_resources_annotations = {
#     "argocd.argoproj.io/compare-options" = "IgnoreExtraneous"
#     "argocd.argoproj.io/sync-options"    = "Prune=false,Delete=false"
#   }
# }

# data "azurerm_kubernetes_cluster" "aks1" {
#   name                = var.cluster_name_aks1
#   resource_group_name = var.rg_name_aks1
# }

data "azurerm_kubernetes_cluster" "aks2" {
  name                = var.cluster_name_aks2
  resource_group_name = var.rg_name_aks2
}

# Output the Cluster details
output "kubernetes_cluster_id" {
  value = data.azurerm_kubernetes_cluster.aks2.id
}
