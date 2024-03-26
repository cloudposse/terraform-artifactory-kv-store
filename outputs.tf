output "id" {
  description = "ID of the created example"
  value       = module.this.enabled ? module.this.id : null
}

output "values" {
  value = module.this.enabled ? coalesce(local.artifactory_output) : null
}
