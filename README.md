# Vault in Kubernetes

This repo provides a demo non prodcution app that works with HashiCorp Vault 

### Installation 
#### Locally
Deploy this follow these steps

Edit the Variables to suit your envrioment and account detail

1. clone this repo
2. Run Terrafom init
3. Run Terraform apply 

Once the apply is compelete connect to your Kubenetes envrioment via your cloud shell and verify the pods are up using kubectl get pods

Now

1. clone this repo into your shell https://github.com/dawright22/app_stack.git
2. change into this repo and run ./full_stack_deploy.sh </br>

#### Via Terraform Cloud (TFC)
If you are new to TFC, complete this tutorial: https://learn.hashicorp.com/collections/terraform/cloud-get-started

1. Fork this repo
2. Set Up your TFC Account and Organization
3. Create a new Workspace and select the "Version control workflow" 
4. Choose the repo you forked
5. Update Variables
6. Queue and Run the plan </br>

**Retrieve and update the Variables in TFC**
Review variables.tf

Create a Service Principal in Azure: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret

What you will require:</br>
```
{
  "appId": "00000000-0000-0000-0000-000000000000",
  "displayName": "azure-cli-2017-06-05-10-41-15",
  "name": "http://azure-cli-2017-06-05-10-41-15",
  "password": "0000-0000-0000-0000-000000000000",
  "tenant": "00000000-0000-0000-0000-000000000000"
}

Add Terraform Variables 
appId : "<appId>"
password : "<password>"`

Add Environment Variables
ARM_SUBSCRIPTION_ID : "<subscription-id>"
ARM_TENANT_ID : "<tenant>"
ARM_CLIENT_SECRET : "<password>"
ARM_CLIENT_ID : "<appId>"
```

### What you get!
A standalone vault instance that can be either OSS (default) or Enterprise to demonstrate dynamic user credentials and trasit data encryption as a service 

### Vault

#### Locally
You can connect to the Vault UI and see the secrets engines enabled using http://<EXTERNAL_IP:8200>

You will need to login in using the ROOT TOKEN from the init.json file located in app_stack/vault/init.json to authenticate

#### Via Terraform Cloud
Get the kubernetes_cluster_name and resource_group_name values
Steps to retrieve external IP:
1. Using Azure CLI, login with created Service Principal account
2. Run ```az aks get-credentials --resource-group <resource_group_name> --name <kubernetes_cluster_name>```
3. Run ```kubectl get services```
4. Connect to the Vault UI and see the secrets engines enabled using http://<EXTERNAL-IP:8200>

it should look like this:

![](/images/vault.png)

### Transit-app

Execute kubectl get svc transit-app to see the ip address to connect too

You can connect to the app UI and add or change record using http://<EXTERNAL_IP:5000>

![](/images/tranist-app.png)


### Clean up

#### Locally
in the app_stack repo run the ./cleanup.sh

#### Via Terraform Cloud
Settings > Destruction and Deletion > Queue destroy plan



