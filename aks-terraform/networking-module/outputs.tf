output "vnet_id" {
    description = "ID of the Virtual Network (VNet). Used within the cluster module to connect the cluster to the defined VNet."
    value       = azurerm_virtual_network.aks-vnet.id
}

output "control_plane_subnet_id" {
    description = "ID of the control plane subnet. Used to specify the subnet where the control plane components of the AKS cluster will be deployed to."
    value       = azurerm_subnet.control-plane-subnet.id
}

output "worker_node_subnet_id" {
    description = "ID of the worker node subnet.  Used to specify the subnet where the worker nodes of the AKS cluster will be deployed to."
    value       = azurerm_subnet.worker-node-subnet.id
}

output "networking_resource_group_name" {
    description = "Name of the Azure Resource Group for networking resources. Used to ensure the cluster module resources are provisioned within the same resource group."
    value       = azurerm_resource_group.networking.name
}

output "aks_nsg_id" {
    description = "ID of the Network Security Group (NSG) for AKS. Used to associate the NSG with the AKS cluster for security rule enforcement and traffic filtering."
    value       = azurerm_network_security_group.aks-nsg.id
}

