locals {
  artifactory_base_uri = trim(var.artifactory_base_uri, "/")

  artifactory_get_output         = { for key, value in local.vals_to_read : key => jsondecode(file(data.artifactory_file.read_kv_pair[key].output_path)) }
  artifactory_get_by_path_output = { for key, value in data.artifactory_file.read_kv_path_file : split(":", key)[0] => jsondecode(file(data.artifactory_file.read_kv_path_file[key].output_path))... }
  artifactory_output             = merge(local.artifactory_get_output, local.artifactory_get_by_path_output)
}

provider "restapi" {
  uri = format("%s/artifactory/%s", local.artifactory_base_uri, var.artifactory_repository)

  headers = {
    "Authorization" = format("Bearer %s", var.artifactory_auth_token)
    "Content-Type"  = "application/json"
  }

  write_returns_object = true
  create_method        = "PUT"
  update_method        = "PUT"
}

provider "artifactory" {
  url          = format("%s/artifactory", local.artifactory_base_uri)
  access_token = var.artifactory_auth_token
}

resource "restapi_object" "write_kv_pair" {
  for_each = local.vals_to_write

  id_attribute = "path"
  read_path    = "{id}"
  update_path  = "{id}"
  destroy_path = "{id}"

  path = format("%s;sensitive=%t", each.key, each.value.sensitive)
  data = jsonencode({
    key   = each.key
    value = each.value.sensitive ? sensitive(each.value.value) : each.value.value
  })
}

data "artifactory_file" "read_kv_pair" {
  for_each = local.vals_to_read

  repository  = var.artifactory_repository
  path        = trim(each.value, "/")
  output_path = format("/tmp/read_kv_pair/%s", each.value)
}

data "artifactory_file_list" "read_kv_path" {
  for_each = local.vals_to_read_by_path

  repository_key = var.artifactory_repository
  deep_listing   = true
  folder_path    = trim(each.value, "/")
}

data "artifactory_file" "read_kv_path_file" {
  for_each = toset(flatten([for key, value in data.artifactory_file_list.read_kv_path : formatlist("%s:%s%s", key, key, value.files.*.uri)]))

  repository  = var.artifactory_repository
  path        = split(":", each.value)[1]
  output_path = format("/tmp/read_kv_path_file/%s", split(":", each.value)[1])
}
