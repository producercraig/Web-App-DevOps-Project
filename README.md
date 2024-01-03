# Web-App-DevOps-Project

Welcome to the Web App DevOps Project repo! This application allows you to efficiently manage and track orders for a potential business. It provides an intuitive user interface for viewing existing orders and adding new ones.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Technology Stack](#technology-stack)
- [Infrastructure](#infrastructure)
- [Contributors](#contributors)
- [License](#license)

## Features

- **Order List:** View a comprehensive list of orders including details like date UUID, user ID, card number, store code, product code, product quantity, order date, and shipping date.
  
![Screenshot 2023-08-31 at 15 48 48](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/3a3bae88-9224-4755-bf62-567beb7bf692)

- **Pagination:** Easily navigate through multiple pages of orders using the built-in pagination feature.
  
![Screenshot 2023-08-31 at 15 49 08](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/d92a045d-b568-4695-b2b9-986874b4ed5a)

- **Add New Order:** Fill out a user-friendly form to add new orders to the system with necessary information.
  
![Screenshot 2023-08-31 at 15 49 26](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/83236d79-6212-4fc3-afa3-3cee88354b1a)

- **Data Validation:** Ensure data accuracy and completeness with required fields, date restrictions, and card number validation.

## Getting Started

### Prerequisites

For the application to succesfully run, you need to install the following packages:

- flask (version 2.2.2)
- pyodbc (version 4.0.39)
- SQLAlchemy (version 2.0.21)
- werkzeug (version 2.2.3)

### Usage

To run the application, you simply need to run the `app.py` script in this repository. Once the application starts you should be able to access it locally at `http://127.0.0.1:5000`. Here you will be meet with the following two pages:

1. **Order List Page:** Navigate to the "Order List" page to view all existing orders. Use the pagination controls to navigate between pages.

2. **Add New Order Page:** Click on the "Add New Order" tab to access the order form. Complete all required fields and ensure that your entries meet the specified criteria.

## Technology Stack

- **Backend:** Flask is used to build the backend of the application, handling routing, data processing, and interactions with the database.

- **Frontend:** The user interface is designed using HTML, CSS, and JavaScript to ensure a smooth and intuitive user experience.

- **Database:** The application employs an Azure SQL Database as its database system to store order-related data.

## Infrastructure

- **Docker:** Included is a dockerfile which can be used to build and run a containerized version of the app.

- **Terraform Modules:** Included is a terraform module enabling the setup of infrastructure upon which the app can be run. Please see information on the modules below:

    1. **Root Module**
        - ***Accessing the AKS cluster***
            - To enable **kubectl** access to the AKS cluster, **cluster_kubeconfig** is defined as an output in the root module (referencing the **aks_kubeconfig** output in **aks-cluster-module** outputs) to enable access to the **kubeconfig** file.
        - ***Resources***
            - **Provider: Azurerm**: The resource provider defined in main.tf. Running version *3.0.0*.
            - **Module integration**: The *networking-module* and *aks-cluster-module* are both referenced here, with input values declared for both.
            - **Credentials**: All credentials/secrets have been removed from main.tf - these will need to be entered in order to apply the configuration to Azure.
    2. **Networking Module**
        - ***Input Variables***
            - **resource_group_name**: The name of the Azure Resource Group. *Default: devopsproject-aks*
            - **location**: The location of the Azure resource. *Default: UK South*
            - **vnet_address_space**: The address space for the virtual network. *Default: 10.0.0.0/16*

        - ***Output Variables***
            - **vnet_id**: ID of the Virtual Network (VNet). Used within the cluster module to connect the cluster to the defined VNet.)
            - **control_plane_subnet_id**: ID of the control plane subnet. Used to specify the subnet where the control plane components of the AKS cluster will be deployed to.
            - **worker_node_subnet_id**: ID of the worker node subnet.  Used to specify the subnet where the worker nodes of the AKS cluster will be deployed to.
            - **networking_resource_group_name**: Name of the Azure Resource Group for networking resources. Used to ensure the cluster module resources are provisioned within the same resource group.
            - **aks_nsg_id**: ID of the Network Security Group (NSG) for AKS. Used to associate the NSG with the AKS cluster for security rule enforcement and traffic filtering.

    3. **AKS Cluster Module**
        - ***Input Variables***
            - **aks_cluster_name**: variable that represents the name of the AKS cluster being created.
            - **cluster_location**: variable that specifies the Azure region where the AKS cluster will be deployed to.
            - **dns_prefix**: variable that defines the DNS prefix of the cluster.
            - **kubernetes_version**: variable that specifies which Kubernetes version the cluster will use.
            - **service_principal_client_id**: variable that provides the Client ID for the service principal associated with the cluster.
            - **service_principal_secret**: variable that supplies the Client Secret for the service principal.
        - ***Output Variables***
            - **resource_group_name** (From the Networking Module)
            - **vnet_id** (From the Networking Module)
            - **control_plane_subnet_id** (From the Networking Module)
            - **worker_node_subnet_id** (From the Networking Module)



## Contributors 

- [Maya Iuga]([https://github.com/maya-a-iuga](https://github.com/maya-a-iuga))
- [Craig Gibbs]([https://github.com/producercraig](https://github.com/producercraig))

## License

This project is licensed under the MIT License. For more details, refer to the [LICENSE](LICENSE) file.
