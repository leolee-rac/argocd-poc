variable "azure_subscription_id" {
  description = "The Azure subscription ID to use for deploying resources."
  type        = string
  default     = "3c88ed6a-35f0-4677-a59d-128fe9b1c351"
}
variable "cluster_name_aks1" {
  description = "kubernetes cluster name to use for deploying resources"
  type        = string
  default     = "shield-v19-prd"
}
variable "cluster_name_aks2" {
  description = "kubernetes cluster name to use for deploying resources"
  type        = string
  default     = "shield-v19-npe"
}

variable "kubernetes_version" {
  description = "kubernetes_version"
  type        = string
  default     = "1.29.7"
}

variable "rg_name_aks1" {
  description = "resource group to use for deploying resources"
  type        = string
  default     = "shield-v19-prd"
}

variable "rg_name_aks2" {
  description = "resource group to use for deploying resources"
  type        = string
  default     = "shield-v19-npe"
}

variable "resource_group_location" {
  type        = string
  default     = "australiaeast"
  description = "Location of the resource group."
}