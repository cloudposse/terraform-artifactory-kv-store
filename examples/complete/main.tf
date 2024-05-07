data "context_config" "this" {}
locals {
  artifactory_base_uri = trim(var.artifactory_base_uri, "/")
  enabled              = data.context_config.this.enabled
}

module "example_write" {
  source = "../.."

  key_prefix      = var.key_prefix
  key_label_order = var.key_label_order

  set = var.set

  artifactory_base_uri   = var.artifactory_base_uri
  artifactory_repository = var.artifactory_repository
  artifactory_auth_token = var.artifactory_auth_token
}

# module "example_read" {
#   source = "../.."

#   key_prefix      = var.key_prefix
#   key_label_order = var.key_label_order

#   get         = var.get
#   get_by_path = var.get_by_path

#   artifactory_base_uri   = var.artifactory_base_uri
#   artifactory_repository = var.artifactory_repository
#   artifactory_auth_token = var.artifactory_auth_token
# }
