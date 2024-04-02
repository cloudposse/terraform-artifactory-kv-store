output "values" {
  value = module.this.enabled ? coalesce(local.artifactory_output) : null
}
