variable "tfe_token" {
  description = "The Terraform Cloud API token"
  sensitive   = true
  type        = string
}

variable "prov_registries" {
  description = "List of provider type registries and their configuration"
  type = list(object({
    name            = string
    module_provider = string
    namespace       = optional(string, "")
    organization    = string
    registry_name   = optional(string, "private")
  }))

  validation {
    condition = alltrue([
      for registry in var.prov_registries :
      contains(["private", "public"], registry.registry_name)
    ])
    error_message = "'registry_name' must be one of 'private' or 'public'."
  }

  validation {
    condition = alltrue([
      for registry in var.prov_registries :
      (registry.namespace != "" ||
      registry.registry_name == "public") ||
      registry.namespace == ""
    ])
    error_message = "'namespace' is required when 'registry_name' is 'public'."
  }

  default = []
}

variable "registry_providers" {
  description = "List of registry type providers and with their configuration"
  type = list(object({
    name          = string
    namespace     = optional(string, null)
    organization  = optional(string, "")
    registry_name = optional(string, "private")
  }))

  validation {
    condition = alltrue([
      for provider in var.registry_providers :
      contains(["private", "public"], provider.registry_name)
    ])
    error_message = "'registry_name' must be one of 'private' or 'public'."
  }

  default = []
}

variable "vcs_registries" {
  description = "List of VCS registries and their configuration"
  type = list(object({
    organization               = string
    display_identifier         = string
    identifier                 = string
    branch                     = optional(string, null)
    initial_version            = optional(string, null)
    oauth_token_id             = optional(string, null)
    github_app_installation_id = optional(string, null)
    tags                       = optional(bool, true)
    tests_enabled              = optional(bool, false)
  }))

  validation {
    condition = alltrue([
      for registry in var.vcs_registries : (
        (registry.branch != null ||
        registry.tags == false) ||
        registry.tags == true
      )
    ])
    error_message = "If 'branch' is set, 'tag' must be 'false'."
  }

  validation {
    condition = alltrue([
      for registry in var.vcs_registries :
      registry.initial_version == null ||
      can(regex("^([0-9]+)\\.([0-9]+)\\.([0-9]+)(-[a-zA-Z0-9-.]+)?(\\+[a-zA-Z0-9-.]+)?$", registry.initial_version))
    ])
    error_message = "initial_version must follow Semantic Versioning format (e.g., 1.0.0, 2.1.3-beta, etc.)."
  }

  default = []
}
