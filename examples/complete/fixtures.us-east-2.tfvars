region = "us-east-2"

namespace = "eg"

environment = "ue2"

stage = "test"

name = "example"

set = {
  "key1"    = { value = "value1", sensitive = false }
  "key2"    = { value = "value2", sensitive = false }
  "key3"    = { value = "value3", sensitive = false }
  "secret1" = { value = "value3", sensitive = true }
}

# Uncomment once the following keys are present in the KV store:
#get = {
#  "key1" = {}
#}
#
#get_by_path = {
#  "eg" = {
#    key_path = "eg"
#  }
#  "eg/test/ue2/example" = {
#    key_path = "eg/test/ue2/example"
#  }
#}
