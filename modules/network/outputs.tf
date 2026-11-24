output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_app_id" {
  value = azurerm_subnet.subnet_app.id
}