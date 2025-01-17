# Launch an Azure Container Registry and an Azure Container Apps cluster in under a minute.

## How to use:


#### I have set this configuration using https://app.terraform.io/. So to make the below configuration work, you'll have to create a project and two workspaces at https://app.terraform.io/. Keep the names of the workspaces same as *azurerm_container_registry* and *azurerm_container_apps* for clarity.

### Add your workspaces configuration to terraform.tf files for both the directories. This information will be provided when a new workspace is created, this is just so that https://app.terraform.io/ can recognize our local terraform configuration and allow remote executions such as init, apply, destroy. The execution actually happens on a remote terraform VM which is abstracted from the user, the output is streamed to the local user terminal. 

```
Here's an example of the terraform configuration you'll get from your workspace:



terraform {
  cloud {

    organization = "<your_organization_name>"

    workspaces {
      name = "<your_workspace_name>"
    }
  }
} 

```

#### After this is done, you'll need to set up below environment variables on https://app.terraform.io/. This can be done in two ways. If you add these variables on a workspace level (for each of your workspaces, which you eventually will have more than one), you'll need to change some of the variables almost every other day, as some variables do change almost everyday in Azure, like *ARM_CLIENT_SECRET*. 

#### To avoid having to change variables for individual workspaces, just add a variable set on a project level, it will be applied to all the workspaces, which is much easier and saves time.

```makefile

ARM_CLIENT_ID
ARM_CLIENT_SECRET
ARM_SUBSCRIPTION_ID
ARM_TENANT_ID


```

#### If you don't know the values of these variables, you can simply run the below command to get these variables, just make sure Azure CLI is configured on your computer. To run the below command you'll need the subscription id of your Azure billing account, this can be found on the Azure billing console.
 
```makefile

az ad sp create-for-rbac --name "my-service-principal" --role Contributor --scopes /subscriptions/<your_subscription_id>


The output will include the variables we need.

```


### First you'll need an image repository for your container images, the latest version of this image will be pulled by Azure Container Apps cluster. You can edit the terraform.tfvars file in the "azurerm_container_registry" and an Azure Container Registry will be created along with an Azure Resource Group. Both our image registry and Azure Container Apps cluster will exist in this resource group.

### After the repository has been created, tag your docker image like this.

```markdown

docker tag <source_image_tag> <name_of_your_image_repository>.azurecr.io/<any_image_name>


You'll need to login to Azure Container Registry before you can push this image.

After loggin in, simply do: 

docker push <name_of_your_image_repository>.azurecr.io/<any_image_name>

```


### To create an Azure Container Apps cluster, go to the azurerm_container_apps directory and change the variables  inside terraform.tfvars. For this one you'll also have to change the azure_container_apps resource in the main.tf, for now. I will modularize and variablize that as well.

