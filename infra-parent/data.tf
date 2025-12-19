data "azurerm_key_vault" "data_kv" {
  name                = "FrontSecret90bga"
  resource_group_name = "Devops60_rg"
}

data "azurerm_key_vault_secret" "username" {
  name         = "Frontvmuser"
  key_vault_id = data.azurerm_key_vault.data_kv.id
}

data "azurerm_key_vault_secret" "password" {
  name         = "Frontvmpass"
  key_vault_id = data.azurerm_key_vault.data_kv.id
}

data "azurerm_key_vault_secret" "backvmname" {
  name         = "Bckvmuser"
  key_vault_id = data.azurerm_key_vault.data_kv.id
}

data "azurerm_key_vault_secret" "backvmpassword" {
  name         = "Backvmpass"
  key_vault_id = data.azurerm_key_vault.data_kv.id
}