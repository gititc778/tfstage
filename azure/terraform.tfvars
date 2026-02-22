location       = "uksouth"
databricks_sku = "standard"



sql_admin_login     = "itcsme"
sql_admin_password  = "Terraform123!"



vm_size              = "Standard_B2s"
vm_admin_username    = "itcsme"
vm_admin_password    = "Terraform123!"

vnet_address_space       = ["10.0.0.0/16"]
vm_subnet_prefix  = ["10.0.1.0/24"]
aks_subnet_prefix = ["10.0.2.0/24"]

aks_vm_size    = "Standard_DS2_v2"
aks_node_count = 2