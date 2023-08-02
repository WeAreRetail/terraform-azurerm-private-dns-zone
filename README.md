# Azure Aware Private DNS Zone

[![Build Status](https://dev.azure.com/weareretail/Tooling/_apis/build/status/mod_azu_private_dns_zone?repoName=mod_azu_private_dns_zone&branchName=master)](https://dev.azure.com/weareretail/Tooling/_build/latest?definitionId=2&repoName=mod_azu_private_dns_zone&branchName=master)[![Unilicence](https://img.shields.io/badge/licence-The%20Unilicence-green)](LICENCE)

This module allows the creation of an Azure Private DNS Zone.

## Naming

Resource naming is based on the Microsoft CAF naming convention best practices. Custom naming is available by setting the parameter `custom_name`. We rely on the official Terraform Azure CAF naming provider to generate resource names when available.

## Usage

```hcl

module "aware_resource_group" {
  source = "WeAreRetail/resource-group/azurerm"

  tags         = module.aware_tagging.tags
  location     = "France Central"
  description  = "My Resource Group"
  caf_prefixes = module.aware_naming.resource_group_prefixes
}

module "aware_private_dns_zone" {
    source = "WeAreRetail/private-dns-zone/azurerm"

    name = "mydomain.com"
    resource_group_name = module.aware_resource_group.name
}

```

<!-- BEGIN_TF_DOCS -->
#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0.2 |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | DNS Zone name | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Parent resource group name | `string` | n/a | yes |
| <a name="input_custom_tags"></a> [custom\_tags](#input\_custom\_tags) | The custom tags to add on the resource. | `map(string)` | `{}` | no |
| <a name="input_description"></a> [description](#input\_description) | Private DNS zone description | `string` | `""` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | Virtual network name | `string` | `null` | no |
| <a name="input_virtual_network_names"></a> [virtual\_network\_names](#input\_virtual\_network\_names) | Virtual network name | `list(object({ name = string, vnet_name = string }))` | `[]` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | Private dns zone resource id. |
| <a name="output_zone_name"></a> [zone\_name](#output\_zone\_name) | Private dns zone name. |
<!-- END_TF_DOCS -->

