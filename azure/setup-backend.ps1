$RESOURCE_GROUP_NAME = "tfproject"
$STORAGE_ACCOUNT_NAME = "projdbktf" + (Get-Random -Minimum 1000 -Maximum 9999)
$CONTAINER_NAME = "tfstate"
$LOCATION = "northeurope"

# Create Resource Group
Write-Host "Creating Resource Group: $RESOURCE_GROUP_NAME..."
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create Storage Account
Write-Host "Creating Storage Account: $STORAGE_ACCOUNT_NAME..."
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Get Storage Account Key
$ACCOUNT_KEY = az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv

# Create Blob Container
Write-Host "Creating Blob Container: $CONTAINER_NAME..."
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY

Write-Host "--------------------------------------------------"
Write-Host "Backend Setup Complete!"
Write-Host "Please update your providers.tf with the following backend configuration:"
Write-Host ""
Write-Host "terraform {"
Write-Host "  backend ""azurerm"" {"
Write-Host "    resource_group_name  = ""$RESOURCE_GROUP_NAME"""
Write-Host "    storage_account_name = ""$STORAGE_ACCOUNT_NAME"""
Write-Host "    container_name       = ""$CONTAINER_NAME"""
Write-Host "    key                  = ""terraform.tfstate"""
Write-Host "  }"
Write-Host "}"
Write-Host "--------------------------------------------------"
