resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.entity_name}"
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet_app" {
  name                 = "snet-app-${var.entity_name}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(var.address_space[0], 8, 1)]
}

resource "azurerm_subnet" "subnet_data" {
  name                 = "snet-data-${var.entity_name}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(var.address_space[0], 8, 2)]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-snet-app-${var.entity_name}"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet_app.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}