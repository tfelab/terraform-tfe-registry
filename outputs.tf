output "tfe_registry_provider_name" {
  value       = [for provider in tfe_registry_provider.this : provider.name]
  description = "The names of the TFE registry providers"
}

output "tfe_registry_module_prov_name" {
  value       = [for registry in tfe_registry_module.prov : registry.name]
  description = "The names of the TFE registry provider type modules"
}

output "tfe_registry_module_vcs_name" {
  value       = [for registry in tfe_registry_module.vcs : registry.name]
  description = "The names of the TFE registry vcs type modules"
}
