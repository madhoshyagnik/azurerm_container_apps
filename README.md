# Launch an Azure Container Registry and an Azure Container Apps cluster in under a minute.

## How to use:

### First you'll need an image repository for your container images, the latest version of this image will be pulled by Azure Container Apps cluster. You can edit the terraform.tfvars file in the "azurerm_container_registry" and an Azure Container Registry will be created along with an Azure Resource Group. Both our image registry and Azure Container Apps cluster will exist in this resource group.

### After the repository has been created, tag your docker image like this.

```markdown

docker tag <source_image_tag> <name_of_your_image_repository>.azurecr.io/<any_image_name>


You'll need to login to Azure Container Registry before you can push this image.

After loggin in, simply do: 

docker push <name_of_your_image_repository>.azurecr.io/<any_image_name>

```


### To create an Azure Container Apps cluster, go to the azurerm_container_apps directory and change the variables  inside terraform.tfvars. For this one you'll also have to change the azure_container_apps resource in the main.tf, for now. I will modularize and variablize that as well.

