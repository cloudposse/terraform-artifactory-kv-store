region = "us-east-2"

namespace = "eg"

environment = "ue2"

stage = "test"

name = "example"

artifactory_base_uri = "https://cloudpossetest.jfrog.io"
artifactory_repository = "kvstore"

set = {
  "key1" = { value = "value1", sensitive = false }
  "key2" = { value = "value2", sensitive = false }
  "key3" = { value = "value3", sensitive = false }
  "secret1" = { value = "value3", sensitive = true }
}

#get = {
#  "key1" = {}
#}
