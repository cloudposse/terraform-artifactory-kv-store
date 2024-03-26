module "example" {
  source = "../.."

  key_prefix      = var.key_prefix
  key_label_order = var.key_label_order

  set         = var.set
  get         = var.get
  get_by_path = var.get_by_path

  context = module.this.context

  restapi_uri        = var.restapi_uri
  restapi_auth_token = var.restapi_auth_token
}
