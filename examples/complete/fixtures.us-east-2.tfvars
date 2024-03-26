region = "us-east-2"

namespace = "eg"

environment = "ue2"

stage = "test"

name = "example"

artifactory_base_uri = "https://cloudpossetest.jfrog.io"
artifactory_repository = "kvstore"

set = {
  "key1" = { value = "a" }
  "key2" = { value = "b" }
  "key3" = { value = "c" }
}

get = {
  "key1" = {}
}
