output "aks_cluster_name" {
    description = "Name of the provisioned AKS cluster."
    value       = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_cluster_id" {
    description = "ID of the AKS cluster."
    value       = azurerm_kubernetes_cluster.aks_cluster.id
}

output "aks_kubeconfig" {
    description = "Captures the Kubernetes configuration file of the cluster."
    value       = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
}