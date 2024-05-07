data "context_config" "this" {}

locals {
  enabled      = data.context_config.this.enabled
  context_vals = local.enabled ? data.context_config.this.values : {}

  // Build a map of key-value pairs to write to the key/value store with a shape of:
  // key = { sensitive = bool, value = string }
  //
  // where the key is the specified key_path or, if not specified, a constructed key path from the context, which also
  // allows namespace, tenant, stage, environment, name and attributes to be overridden and joins the
  vals_to_write = local.enabled && var.set != {} ? ({ for key, value in var.set :
    coalesce(
      var.set[key]["key_path"],
    join("/", concat([var.key_prefix], compact(flatten([for label in var.key_label_order : [try(coalesce(try(var.set[key]["properties"][label], ""), local.context_vals[label]), "")]]))), [key])) => { sensitive = value.sensitive, value = value.value }
  }) : null

  // Build a map of keys to read from the key/value store and the key they should be output to, with a shape of: { output_key_name = key_path_to_read_from }
  vals_to_read = local.enabled && var.get != {} ? ({
    for key, value in var.get :
  key => coalesce(var.get[key]["key_path"], join("/", concat([var.key_prefix], compact(flatten([for label in var.key_label_order : [try(coalesce(try(var.get[key]["properties"][label], ""), local.context_vals[label]), "")]])), [key]))) }) : {}

  vals_to_read_by_path = local.enabled && var.get_by_path != {} ? ({
    for key, value in var.get_by_path :
  key => coalesce(var.get_by_path[key]["key_path"], join("/", concat([var.key_prefix], compact(flatten([for label in var.key_label_order : [try(coalesce(try(var.get[key]["properties"][label], ""), local.context_vals[label]), "")]])), [key]))) }) : {}
}
