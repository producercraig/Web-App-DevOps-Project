output "cluster_kubeconfig" {
    description = "Captures the Kubernetes configuration file of the cluster."
    value       = module.aks_cluster.aks_kubeconfig
    sensitive = true
}