package test

import (
	"fmt"
	"os"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	testStructure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

func cleanup(t *testing.T, terraformOptions *terraform.Options, tempTestFolder string) {
	terraform.Destroy(t, terraformOptions)
	os.RemoveAll(tempTestFolder)
}

func TestExamplesComplete(t *testing.T) {
	t.Parallel()

	// Generate a random ID to prevent naming conflicts
	randID := strings.ToLower(random.UniqueId())

	rootFolder := "../../"
	terraformFolderRelativeToRoot := "examples/complete"
	varFiles := []string{"fixtures.us-east-2.tfvars"}

	tempTestFolder := testStructure.CopyTerraformFolderToTemp(t, rootFolder, terraformFolderRelativeToRoot)
	defer os.RemoveAll(tempTestFolder)

	auth_token := os.Getenv("JFROG_ACCESS_TOKEN")
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: tempTestFolder,
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: varFiles,
		Vars: map[string]interface{}{
			"artifactory_auth_token": auth_token,
			"key_prefix":             fmt.Sprintf("/%s", randID),
			"set": map[string]interface{}{
				"key1": map[string]interface{}{
					"value":     "key1val",
					"sensitive": false,
				},
				"key2": map[string]interface{}{
					"value":     "key2val",
					"sensitive": false,
				},
				"key3": map[string]interface{}{
					"value":     "key3val",
					"sensitive": false,
				},
			},
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer cleanup(t, terraformOptions, tempTestFolder)
	terraform.InitAndApply(t, terraformOptions)

	// Now use a different set of options to test that we can get the values written in the previous step
	tempGetTestFolder := testStructure.CopyTerraformFolderToTemp(t, rootFolder, terraformFolderRelativeToRoot)
	defer os.RemoveAll(tempGetTestFolder)

	terraformGetOptions := &terraform.Options{
		TerraformDir: tempGetTestFolder,
		Upgrade:      true,
		VarFiles:     varFiles,
		Vars: map[string]interface{}{
			"artifactory_auth_token": auth_token,
			"key_prefix":             fmt.Sprintf("/%s", randID),
			"get": map[string]interface{}{
				"key1": map[string]interface{}{},
				"key2": map[string]interface{}{},
				"key3": map[string]interface{}{},
			},
		},
	}

	terraform.InitAndApply(t, terraformGetOptions)
	defer cleanup(t, terraformGetOptions, tempGetTestFolder)

	// Run `terraform output` to get the value of an output variable
	values := terraform.OutputMapOfObjects(t, terraformGetOptions, "values")
	assert.Equal(t, "value1", values["key1"].(map[string]interface{})["value"])
	assert.Equal(t, "value2", values["key2"].(map[string]interface{})["value"])
	assert.Equal(t, "value3", values["key3"].(map[string]interface{})["value"])
}

func TestExamplesCompleteDisabled(t *testing.T) {
	t.Parallel()

	rootFolder := "../../"
	terraformFolderRelativeToRoot := "examples/complete"
	varFiles := []string{"fixtures.us-east-2.tfvars"}

	tempTestFolder := testStructure.CopyTerraformFolderToTemp(t, rootFolder, terraformFolderRelativeToRoot)

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: tempTestFolder,
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: varFiles,
		Vars: map[string]interface{}{
			"enabled": "false",
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer cleanup(t, terraformOptions, tempTestFolder)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	results := terraform.InitAndApply(t, terraformOptions)

	// Should complete successfully without creating or changing any resources
	assert.Contains(t, results, "Resources: 0 added, 0 changed, 0 destroyed.")
}
