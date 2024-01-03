# Web-App-DevOps-Project

Welcome to the Web App DevOps Project repo! This application allows you to efficiently manage and track orders for a potential business. It provides an intuitive user interface for viewing existing orders and adding new ones.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Technology Stack](#technology-stack)
- [Infrastructure](#infrastructure)
- [Deployment](#deployment)
- [Testing](#testing)
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

## Deployment

- **Kubernetes**
    - ***Deployment Manifest***: The deployment manifest (top section of **application-manifest.yaml**) declares a Kubernetes deployment named *flask-app-deployment*. It has the following characteristics:
        - **Name**: flask-app-deployment
        - **App**: flask-app (this is the name assigned to the web app upon deployment for the purposes of selection/port opening via the associated service.)
        - **Update Strategy**: RollingUpdate, with a max surge of **1** and a max unavailable of **1**. This means that when rolling updates are applied, the deployment is able to create one additional replica if required, to ensure no downtime. The max unavailable of 1 should also ensure that only one pod is being updated at a time. This strategy also allows for rollbacks in the event of an update occuring which causes issues.
        - **Image**: The image for the app is hosted on dockerhub, with the name/tag of **producercraig/devopsproject:0.1**. The tag would ideally be changed to 'latest' during any external rollout to ensure that the application image is kept up-to-date.
        - **Container Port**: The port provided is 5000, which matches the port opened in the above Terraform configuration. This allows access to the web app.
    - ***Service Manifest***: The service manifest (bottom section of **application-manifest.yaml**) declares a Kubernetes service named *flask-app-service*. It has the following characteristics:
        - **Name**: flask-app-service
        - **Type**: ClusterIP - this was chosen to allow internal access of the web app while in development.
        - **Ports**: Traffic received on port 80 (via a web browser) is forwarded to the target port of 5000, as detailed above.

## Testing & Distribution

- **Functional Testing**
    - The app was tested by port forwarding port 5000 on localhost, to access the web app and ensure that all functionality was behaving as intended.
- **Load Testing**
    - As the app has been declared with 2 replicas, it would be beneficial to perform load testing to simulate traffic and ensure that the application performs well under load.
- **Validation & Monitoring**
    - It would be beneficial to implement a monitoring solution (perhaps within Azure) to track the application's performance and overall health. This would help in catching and addressing any issues.
- **Internal Access**
    - Internal access could be granted by way of RBAC to manage which users can access the application within the cluster, to further improve security and assist with testing & further development.
    - Steps involved:
        1. Configure a Kubernetes Service (like the flask-app-service defined above) to expose the application within the internal network.
        2. Use Kubernetes namespaces to isolate the application and control access as required.
- **External Access**
    - For external access, an ingress controller would be required to provide an entry point for external traffic and routing it to *flask-app-servive* as defined above. SSL certification would be a consideration here also, to enable secure HTTPS access.
    - Steps involved:
        1. Deploy an Ingress resource to expose the service externally.
        2. Configure DNS to point to the Ingress controller's external IP.
        3. Apply SSL certificate for secure HTTPS access.
    



## Contributors 

- [Maya Iuga]([https://github.com/maya-a-iuga](https://github.com/maya-a-iuga))
- [Craig Gibbs]([https://github.com/producercraig](https://github.com/producercraig))

## License

This project is licensed under the MIT License. For more details, refer to the [LICENSE](LICENSE) file.
