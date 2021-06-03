terraform {
  # backend "remote" {
  #   organization = "hashicorp-learn"    
  #   workspaces {
  #     name = "learn-terraform-pipelines-k8s"
  #   }
  # }
required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0.2"
    }
}

required_version = "~> 0.14"
}


provider "azurerm" {
features {}
}

resource "random_pet" "name" {
  prefix = "k8s-vault"
  length = 1
}

# Retrieve AKS cluster information

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.default.kube_config.0.host
  username               = azurerm_kubernetes_cluster.default.kube_config.0.username
  password               = azurerm_kubernetes_cluster.default.kube_config.0.password
  client_certificate     = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
  host                   = azurerm_kubernetes_cluster.default.kube_config.0.host
  username               = azurerm_kubernetes_cluster.default.kube_config.0.username
  password               = azurerm_kubernetes_cluster.default.kube_config.0.password
  client_certificate     = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
  }
}