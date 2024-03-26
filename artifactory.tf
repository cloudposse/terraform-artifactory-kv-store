provider "restapi" {
  uri = var.restapi_uri
  debug = true

  headers = {
    "Authorization" = format("Bearer %s", var.restapi_auth_token)
    "Content-Type" = "application/json"
  }

  write_returns_object = true
  create_method  = "PUT"
  update_method  = "PUT"
}

resource "restapi_object" "write_kv_pair" {
  for_each = local.vals_to_write

  id_attribute = "path"
  read_path = "{id}"
  update_path = "{id}"
  destroy_path = "{id}"

  path = each.key
  data = format("{\"value\": \"%s\"}", each.value.value)
}

