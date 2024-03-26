module "example" {
  source = "../.."

  key_prefix      = var.key_prefix
  key_label_order = var.key_label_order

  set         = var.set
  get         = var.get
  get_by_path = var.get_by_path

  context = module.this.context

  artifactory_base_uri = var.artifactory_base_uri
  artifactory_repository = var.artifactory_repository
  artifactory_auth_token = var.artifactory_auth_token
}
