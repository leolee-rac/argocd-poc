
variable "cluster_name_aks" {
  description = "kubernetes cluster name to use for deploying resources"
  type        = string
  default     = "minikube"
}
variable "rg_name_aks" {
  description = "resource group to use for deploying resources"
  type        = string
  default     = "minikube"
}
