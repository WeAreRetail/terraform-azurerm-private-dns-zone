# Remark: virtual_network_names and virtual_network_name are exclusives
#         If virtual_network_names is defined, virtual_network_name is not taken into account.
locals {
  vnets_map       = { for vnet in var.virtual_network_names : vnet.name => vnet }
  single_vnet_map = length(var.virtual_network_names) > 0 ? {} : { for single_vnet in [var.virtual_network_name] : "single_vnet" => { name : single_vnet, vnet_name : single_vnet } }
  merged_vnets    = merge(local.vnets_map, local.single_vnet_map)
}


data "azurerm_virtual_network" "vnets" {
  for_each            = local.merged_vnets
  name                = each.value.vnet_name
  resource_group_name = var.resource_group_name
}


data "azurerm_resource_group" "parent_group" {
  name = var.resource_group_name
}

# create the resource
locals {
  specific_tags = {
    "description" = var.description
  }

  parent_tags = { for n, v in data.azurerm_resource_group.parent_group.tags : n => v if n != "description" }
  tags        = { for n, v in merge(local.parent_tags, local.specific_tags) : n => v if v != "" }
}

resource "azurerm_private_dns_zone" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = local.tags
}

# create link to vnet
resource "azurerm_private_dns_zone_virtual_network_link" "multi_link" {
  for_each = local.merged_vnets

  name                  = "vnet-link-${each.value.vnet_name}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = data.azurerm_virtual_network.vnets[each.key].id
  tags                  = local.tags
}
