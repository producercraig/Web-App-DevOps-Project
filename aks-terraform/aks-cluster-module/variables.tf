# aks-cluster/variables.tf

variable "aks_cluster_name" {
    description = "Variable that represents the name of the AKS cluster being created"
    type = string
}

variable "cluster_location" {
    description = "Variable that specifies the Azure region where the AKS cluster will be deployed to"
    type = string
}

variable "dns_prefix" {
    description = "Variable that defines the DNS prefix of cluster"
    type = string
}

variable "kubernetes_version" {
    description = "Variable that specifies which Kubernetes version the cluster will use"
    type = string
}

variable "service_principal_client_id" {
    description = "Variable that provides the Client ID for the service principal associated with the cluster"
    type = string
}

variable "service_principal_client_secret" {
    description = "Variable that supplies the Client Secret for the service principal"
    type = string
}

# Input variables from the networking module
variable "resource_group_name" {
    type = string
}

variable "vnet_id" {
    type = string
}

variable "control_plane_subnet_id" {
    type = string
}

variable "worker_node_subnet_id" {
    type = string
}