terraform {
  required_version = ">=1.0"

  required_providers {
    #kubectl = {
    #  source  = "gavinbunney/kubectl"
    #  version = ">= 1.7.0"
    #}
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>3.0"
    }
    # argocd = {
    #   source = "oboukili/argocd"
    # }
  }
}

# provider "kubernetes" {
#   host                   = data.azurerm_kubernetes_cluster.main.kube_config.0.host
#   username               = data.azurerm_kubernetes_cluster.main.kube_config.0.username
#   password               = data.azurerm_kubernetes_cluster.main.kube_config.0.password
#   client_certificate     = base64decode(data.azurerm_kubernetes_cluster.main.kube_config.0.client_certificate)
#   client_key             = base64decode(data.azurerm_kubernetes_cluster.main.kube_config.0.client_key)
#   cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.main.kube_config.0.cluster_ca_certificate)
# }


# provider "kubernetes" {
#   alias = "control_plane"
#   host                   = data.azurerm_kubernetes_cluster.main.kube_config.0.host
#   username               = data.azurerm_kubernetes_cluster.main.kube_config.0.username
#   password               = data.azurerm_kubernetes_cluster.main.kube_config.0.password
#   client_certificate     = base64decode(data.azurerm_kubernetes_cluster.main.kube_config.0.client_certificate)
#   client_key             = base64decode(data.azurerm_kubernetes_cluster.main.kube_config.0.client_key)
#   cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.main.kube_config.0.cluster_ca_certificate)
# }

provider "kubernetes" {
  alias = "aks1"
  # host                   = data.azurerm_kubernetes_cluster.aks1.kube_config.0.host
  # username               = data.azurerm_kubernetes_cluster.aks1.kube_config.0.username
  # password               = data.azurerm_kubernetes_cluster.aks1.kube_config.0.password
  # client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks1.kube_config.0.client_certificate)
  # client_key             = base64decode(data.azurerm_kubernetes_cluster.aks1.kube_config.0.client_key)
  # cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks1.kube_config.0.cluster_ca_certificate)
  config_path = "~/.kube/config"
}

provider "kubernetes" {
  /* host                   = data.azurerm_kubernetes_cluster.aks2.kube_config.0.host
  username               = data.azurerm_kubernetes_cluster.aks2.kube_config.0.username
  password               = data.azurerm_kubernetes_cluster.aks2.kube_config.0.password
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks2.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.aks2.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks2.kube_config.0.cluster_ca_certificate) */
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    # host                   = data.azurerm_kubernetes_cluster.aks2.kube_config.0.host
    # username               = data.azurerm_kubernetes_cluster.aks2.kube_config.0.username
    # password               = data.azurerm_kubernetes_cluster.aks2.kube_config.0.password
    # client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks2.kube_config.0.client_certificate)
    # client_key             = base64decode(data.azurerm_kubernetes_cluster.aks2.kube_config.0.client_key)
    # cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks2.kube_config.0.cluster_ca_certificate)
    config_path = "~/.kube/config"
  }
}
provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
}

# output "main_user" {
#   value = data.azurerm_kubernetes_cluster.aks2.kube_config.0.username
#   sensitive = true
# }
# output "main_pass" {
#   value = data.azurerm_kubernetes_cluster.aks2.kube_config.0.password
#   sensitive = true
# }