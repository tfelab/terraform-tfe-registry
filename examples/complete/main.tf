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
