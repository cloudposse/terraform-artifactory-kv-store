output "values" {
  value = local.enabled ? coalesce(local.artifactory_output) : null
}
