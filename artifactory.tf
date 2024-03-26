locals {
  artifactory_base_uri = trim(var.artifactory_base_uri, "/")

  artifactory_get_output = { for key, value in local.vals_to_read : key => jsondecode(file(data.artifactory_file.read_kv_pair[key].output_path)) }
  artifactory_output = merge(local.artifactory_get_output)
}

provider "restapi" {
  uri   = format("%s/artifactory/%s", local.artifactory_base_uri, var.artifactory_repository)

  headers = {
    "Authorization" = format("Bearer %s", var.artifactory_auth_token)
    "Content-Type"  = "application/json"
  }

  write_returns_object = true
  create_method        = "PUT"
  update_method        = "PUT"
}

provider "artifactory" {
  url           = format("%s/artifactory", local.artifactory_base_uri)
  access_token  = var.artifactory_auth_token
}

resource "restapi_object" "write_kv_pair" {
  for_each = local.vals_to_write

  id_attribute = "path"
  read_path    = "{id}"
  update_path  = "{id}"
  destroy_path = "{id}"

  path = each.key
  data = jsonencode({
    key = each.key
    value = each.value.value
  })
}

data "artifactory_file" "read_kv_pair" {
   for_each = local.vals_to_read

   repository = var.artifactory_repository
   path       = trim(each.value, "/")
   output_path  = format("/tmp/%s", each.value)
}
