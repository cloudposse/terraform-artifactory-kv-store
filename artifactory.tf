locals {
  artifactory_base_uri = trim(var.artifactory_base_uri, "/")

  artifactory_get_output         = { for key, value in local.vals_to_read : key => jsondecode(file(data.artifactory_file.read_kv_pair[key].output_path)) }
  artifactory_get_by_path_output = { for key, value in data.artifactory_file.read_kv_path_file : split(":", key)[0] => jsondecode(file(data.artifactory_file.read_kv_path_file[key].output_path))... }
  // Instead of using a map of lists, we use : as a delimiter such that each value is a string with the format "key:path".
  // Using this one dimensional list (as opposed to a map of lists or a two-dimensional list) and then using the split function to extract the key allows us to use the list in the for_each meta-argument,
  // without encountering the following error:
  // 'The "for_each" set includes values derived from resource attributes that cannot be determined until apply...'
  // This error typically occurs when using a two dimensional list (or similar) in conjunction with a function such as 'flatten', and then providing said data structure to the for_each meta-argument.
  artifactory_output = merge(local.artifactory_get_output, local.artifactory_get_by_path_output)
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
  for_each = toset(flatten([for key, value in data.artifactory_file_list.read_kv_path : formatlist("%s:%s%s", key, trim(local.vals_to_read_by_path[key], "/"), value.files.*.uri)]))

  repository  = var.artifactory_repository
  path        = split(":", each.value)[1]
  output_path = format("/tmp/read_kv_path_file/%s", split(":", each.value)[1])
}
