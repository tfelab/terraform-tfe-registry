# TFE Registry Terraform module

Terraform module to manage Terraform Enterprise registry modules and providers.

## Usage

[Generating user token](https://app.terraform.io/app/settings/tokens)

### Complete

```hcl
module "tfe-registry" {
  source = "../.."

  tfe_token = var.token

  registry_providers = [
    {
      name          = "external"
      namespace     = "hashicorp"
      organization  = "tfelab"
      registry_name = "public"
    },
    {
      name          = "null"
      namespace     = "hashicorp"
      organization  = "tfelab"
      registry_name = "public"
    },
    {
      name         = "test"
      organization = "tfelab"
    }
  ]

  prov_registries = [
    {
      name            = "vpc"
      module_provider = "aws"
      namespace       = "terraform-aws-modules"
      organization    = "tfelab"
      registry_name   = "public"
    },
    {
      name            = "security-group"
      module_provider = "aws"
      namespace       = "terraform-aws-modules"
      organization    = "tfelab"
      registry_name   = "public"
    },
    {
      name            = "test"
      module_provider = "testt"
      organization    = "tfelab"
      registry_name   = "private"
    }
  ]

  vcs_registries = [
    {
      organization       = "tfelab"
      display_identifier = "tfelab/terraform-tfe-org"
      identifier         = "tfelab/terraform-tfe-org"
      oauth_token_id     = data.tfe_oauth_client.client.oauth_token_id
      tags               = true
    },
    {
      organization       = "tfelab"
      display_identifier = "tfelab/terraform-tfe-registry"
      identifier         = "tfelab/terraform-tfe-registry"
      branch             = "main"
      oauth_token_id     = data.tfe_oauth_client.client.oauth_token_id
      tags               = false
      tests_enabled      = false
    },
  ]
}

data "tfe_oauth_client" "client" {
  name             = "github-tfelab"
  organization     = "tfelab"
  service_provider = "github"
}
```

## Examples

- [Complete](https://github.com/tfelab/terraform-tfe-registry/tree/main/examples/complete)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.12 |
| <a name="requirement_tfe"></a> [tfe](#requirement_tfe) | >= 0.58.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider_tfe) | >= 0.58.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_registry_provider.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/registry_provider) | resource |
| [tfe_registry_module.prov](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/registry_module) | resource |
| [tfe_registry_module.vcs](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/registry_module) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tfe_token"></a> [tfe_token](#input_tfe_token) | The token use in connecting to TFE | `string` | `null` | yes |
| <a name="input_prov_registries"></a> [prov_registries](#input_prov_registries) | List of provider type registries and their configuration | `list` | [] | no |
| <a name="input_registry_providers"></a> [registry_providers](#input_registry_providers) | List of registry type providers and with their configuration | `list` | [] | no |
| <a name="input_vcs_registries"></a> [vcs_registries](#input_vcs_registries) | List of VCS registries and their configuration | `list` | [] | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tfe_registry_provider_name"></a> [tfe_registry_provider_name](#output_tfe_registry_provider_name) | The names of the TFE registry providers |
| <a name="output_tfe_registry_module_prov_name"></a> [tfe_registry_module_prov_name](#output_tfe_registry_module_prov_name) | The names of the TFE registry provider type modules |
| <a name="output_tfe_registry_module_vcs_name"></a> [tfe_registry_module_vcs_name](#output_tfe_registry_module_vcs_name) | The names of the TFE registry vcs type modules |

## Authors

Module is maintained by [John Ajera](https://github.com/jajera).

## License

MIT Licensed. See [LICENSE](https://github.com/tfelab/terraform-tfe-registry/tree/main/LICENSE) for full details.
