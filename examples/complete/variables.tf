variable "enabled" {
  description = "Whether to enable the context provider."
  type        = bool
  default     = true
}

variable "key_prefix" {
  description = "The prefix to use for the key path. This is useful for storing all keys for a module under a common prefix."
  type        = string
  nullable    = false
  default     = ""
}

variable "get" {
  description = <<-EOT
    A map of keys to read from the key/value store. The key_path, namespace,
    tenant, stage, environment, and name are derived from context by default,
    but can be overridden by specifying a value in the map.
    EOT
  type = map(object(
    {
      key_path    = optional(string),
      namespace   = optional(string),
      tenant      = optional(string),
      stage       = optional(string),
      environment = optional(string),
      name        = optional(string),
      attributes  = optional(list(string))
    }
    )
  )
  default  = {}
  nullable = false
}

variable "get_by_path" {
  description = <<-EOT
    A map of keys to read from the key/value store. The key_path, namespace,
    tenant, stage, environment, and name are derived from context by default,
    but can be overridden by specifying a value in the map.
    EOT
  type = map(object(
    {
      key_path    = optional(string),
      namespace   = optional(string),
      tenant      = optional(string),
      stage       = optional(string),
      environment = optional(string),
      name        = optional(string),
      attributes  = optional(list(string))
    }
    )
  )
  default  = {}
  nullable = false
}

variable "set" {
  description = <<-EOT
  A map of key-value pairs to write to the key/value store. The key_path,
  namespace, tenant, stage, environment, and name are derived from context by
  default, but can be overridden by specifying a value in the map.
  EOT
  type = map(object(
    {
      key_path    = optional(string),
      value       = string,
      sensitive   = bool,
      namespace   = optional(string),
      tenant      = optional(string),
      stage       = optional(string),
      environment = optional(string),
      name        = optional(string),
      attributes  = optional(list(string))
    }
    )
  )
  default  = {}
  nullable = false
}


variable "key_label_order" {
  type        = list(string)
  default     = []
  description = <<-EOT
   The order in which the labels (ID elements) appear in the full key path. For example, if you want a key path to
    look like /{namespace}/{tenant}/{stage}/{environment}/name, you would set this varibale to
    ["namespace", "tenant", "stage", "environment", "name"].
    EOT
}

variable "artifactory_base_uri" {
  description = "The base URI for artifactory."
  type        = string
}

variable "artifactory_repository" {
  description = "The name of the artifactory repository."
  type        = string
}

variable "artifactory_auth_token" {
  description = <<-EOT
    The authentication token to use when accessing artifactory. Getting this value from the environment is supported
    with JFROG_ACCESS_TOKEN or ARTIFACTORY_ACCESS_TOKEN variables.
    EOT
  type        = string
  default     = null
}
