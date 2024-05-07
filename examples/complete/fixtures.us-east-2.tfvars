artifactory_base_uri   = "https://cloudpossetest1.jfrog.io"
artifactory_repository = "shared-state-generic-local"

set = {
  "key1"    = { value = "value1", sensitive = false }
  "key2"    = { value = "value2", sensitive = false }
  "key3"    = { value = "value3", sensitive = false }
  "secret1" = { value = "value3", sensitive = true }
}

key_label_order = [
  "namespace",
  "tenant",
  "ou",
  "environment",
  "region",
  "workload",
  "discriminator"
]

# Uncomment once the following keys are present in the KV store:
get = {
  "key1" = {}
}

get_by_path = {
  "eg" = {
    key_path = "eg"
  }
  "eg/test/ue2/example" = {
    key_path = "eg/acme/core/test/ue2/example"
  }
}
