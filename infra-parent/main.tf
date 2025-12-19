module "resource_group" {
  source      = "../child-modules/azurerm_resource_group"
  rg_name     = "Aktodorg"
  rg_location = "central india"
}
module "Modpip_frontend" {
  source       = "../child-modules/Public_ip"
  depends_on   = [module.resource_group]
  pip_name     = "frontendabhipip"
  pip_location = "central india"
  rg_name      = "Aktodorg"
  allocation_method = "Static"
}

module "Modvnet" {
  source             = "../child-modules/virtual_network"
  depends_on         = [module.resource_group]
  vnet_name          = "Aktodovent"
  vnet_location      = "central india"
  rg_name            = "Aktodorg"
  vent_address_space = ["10.0.0.0/16"]

}
module "frontend_subnet" {
  depends_on       = [module.Modvnet]
  source           = "../child-modules/subnet"
  subnet_name      = "frontendsubnet"
  vnet_name        = "Aktodovent"
  rg_name          = "Aktodorg"
  address_prefixes = ["10.0.1.0/24"]

}

module "backend_subnet" {
  depends_on       = [module.Modvnet]
  source           = "../child-modules/subnet"
  subnet_name      = "backendsubnet"
  vnet_name        = "Aktodovent"
  rg_name          = "Aktodorg"
  address_prefixes = ["10.0.2.0/24"]

}
module "frontend_nsg" {
  source       = "../child-modules/NSG"
  depends_on   = [module.resource_group]
  nsg_name     = "frontendnsg"
  nsg_location = "central india"
  rg_name      = "Aktodorg"
}
module "backend_nsg" {
  source       = "../child-modules/NSG"
  depends_on   = [module.resource_group]
  nsg_name     = "backendnsg"
  nsg_location = "central india"
  rg_name      = "Aktodorg"
}

module "key_vault" {
  source = "../child-modules/azurerm_key_vault"
  kv_name = "FrontSecret90bga"
  kv_location =  "central india"
  resg_name  =   "Devops60_rg"
  
}


module "frontend_vm" {
  source                = "../child-modules/Linux_VM"
  depends_on            = [module.frontend_subnet,module.key_vault, module.Modpip_frontend, module.resource_group, module.Modvnet]
  rg_name               = "Aktodorg"
  vm_name               = "frontendvm"
  vm_location           = "central india"
  nic_name              = "frontendabhinic"
  nic_location          = "central india"
  ip_configuration_name = "ipconftodo"
  subnet_name           = "frontendsubnet"
  pip_name              = "frontendabhipip"
  vnet_name             = "Aktodovent"
  nsg_name              = "frontendnsg"
  kv_name               = "FrontSecret90bga"
  private_ip_address_allocation = "Static"
  admin_username = data.azurerm_key_vault_secret.username.value
  admin_password = data.azurerm_key_vault_secret.password.value

}

module "backend_vm" {
  source                = "../child-modules/Linux_VM"
  depends_on            = [module.backend_subnet, module.resource_group, module.Modvnet, module.key_vault]
  rg_name               = "Aktodorg"
  vm_name               = "backendvm"
  vm_location           = "central india"
  nic_name              = "backendabhinic"
  nic_location          = "central india"
  ip_configuration_name = "ipconfabhi"
  subnet_name           = "backendsubnet"
  pip_name              = "backendabhipip"
  vnet_name             = "Aktodovent"
  nsg_name              = "backendnsg"
  kv_name               = "FrontSecret90bga"
  private_ip_address_allocation = "Static"
  admin_username = data.azurerm_key_vault_secret.backvmname.value
  admin_password = data.azurerm_key_vault_secret.backvmpassword.value
}


