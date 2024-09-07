###############################
# REGISTRY PROVIDERS
###############################

resource "tfe_registry_provider" "this" {
  for_each = { for provider in var.registry_providers : provider.name => provider }

  name          = each.value.name
  namespace     = each.value.namespace
  organization  = each.value.organization
  registry_name = each.value.registry_name
}

###############################
# PROVIDER TYPE REGISTRY MODULES
###############################

resource "tfe_registry_module" "prov" {
  for_each = { for registry in var.prov_registries : "${registry.organization}-${registry.namespace}-${registry.name}-${registry.registry_name}" => registry }

  name            = each.value.name
  module_provider = each.value.module_provider
  namespace       = each.value.namespace
  organization    = each.value.organization
  registry_name   = each.value.registry_name
}

###############################
# VCS TYPE REGISTRY MODULES
###############################

resource "tfe_registry_module" "vcs" {
  for_each = { for registry in var.vcs_registries : registry.identifier => registry }

  organization = each.value.organization

  initial_version = each.value.initial_version

  vcs_repo {
    identifier                 = each.value.identifier
    display_identifier         = each.value.display_identifier
    branch                     = each.value.branch
    oauth_token_id             = each.value.oauth_token_id
    github_app_installation_id = each.value.github_app_installation_id
    tags                       = each.value.tags
  }

  dynamic "test_config" {
    for_each = each.value.tags ? [] : [1]

    content {
      tests_enabled = each.value.tests_enabled
    }
  }
}
