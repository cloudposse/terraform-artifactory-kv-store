output "values" {
  value       = local.enabled ? coalesce(local.artifactory_output) : null
  description = "the values retrieved with the kv store"
}
