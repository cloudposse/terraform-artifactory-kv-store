

<!-- markdownlint-disable -->
<a href="https://cpco.io/homepage"><img src="https://github.com/cloudposse/terraform-artifactory-kv-store/blob/main/.github/banner.png?raw=true" alt="Project Banner"/></a><br/>
    <p align="right">
<a href="https://github.com/cloudposse/terraform-artifactory-kv-store/releases/latest"><img src="https://img.shields.io/github/release/cloudposse/terraform-artifactory-kv-store.svg?style=for-the-badge" alt="Latest Release"/></a><a href="https://github.com/cloudposse/terraform-artifactory-kv-store/commits"><img src="https://img.shields.io/github/last-commit/cloudposse/terraform-artifactory-kv-store.svg?style=for-the-badge" alt="Last Updated"/></a><a href="https://slack.cloudposse.com"><img src="https://slack.cloudposse.com/for-the-badge.svg" alt="Slack Community"/></a></p>
<!-- markdownlint-restore -->

<!--




  ** DO NOT EDIT THIS FILE
  **
  ** This file was automatically generated by the `cloudposse/build-harness`.
  ** 1) Make all changes to `README.yaml`
  ** 2) Run `make init` (you only need to do this once)
  ** 3) Run`make readme` to rebuild this file.
  **
  ** (We maintain HUNDREDS of open source projects. This is how we maintain our sanity.)
  **





-->

This module is a key/value store for storing configuration data that should be shared among terraform root
modules. The backend for this key/value store is a generic Artifactory repository.


> [!TIP]
> #### 👽 Use Atmos with Terraform
> Cloud Posse uses [`atmos`](https://atmos.tools) to easily orchestrate multiple environments using Terraform. <br/>
> Works with [Github Actions](https://atmos.tools/integrations/github-actions/), [Atlantis](https://atmos.tools/integrations/atlantis), or [Spacelift](https://atmos.tools/integrations/spacelift).
>
> <details>
> <summary><strong>Watch demo of using Atmos with Terraform</strong></summary>
> <img src="https://github.com/cloudposse/atmos/blob/master/docs/demo.gif?raw=true"/><br/>
> <i>Example of running <a href="https://atmos.tools"><code>atmos</code></a> to manage infrastructure from our <a href="https://atmos.tools/quick-start/">Quick Start</a> tutorial.</i>
> </detalis>


## Introduction






## Usage

For a complete example, see [examples/complete](examples/complete).

For automated tests of the complete example using [bats](https://github.com/bats-core/bats-core) and [Terratest](https://github.com/gruntwork-io/terratest)
(which tests and deploys the example on AWS), see [test](test).

```hcl

module "example" {
  source  = "cloudposse/kv-store/artifactory"
  # Cloud Posse recommends pinning every module to a specific version
  # version = "x.x.x"

  set = {
    "key1" = {value = "value1", sensative = false }
    "key2" = {value = "value2", sensative = true }
  }

  context = module.label.this
}
```

> [!IMPORTANT]
> In Cloud Posse's examples, we avoid pinning modules to specific versions to prevent discrepancies between the documentation
> and the latest released versions. However, for your own projects, we strongly advise pinning each module to the exact version
> you're using. This practice ensures the stability of your infrastructure. Additionally, we recommend implementing a systematic
> approach for updating versions to avoid unexpected changes.




## Quick Start

Here's how to get started...
## Examples

Here is an example of using this module:
- [`examples/complete`](https://github.com/cloudposse/terraform-artifactory-kv-store/) - complete example of using this module




<!-- markdownlint-disable -->
## Makefile Targets
```text
Available targets:

  help                                Help screen
  help/all                            Display help for all targets
  help/short                          This help short screen
  lint                                Lint terraform code

```
<!-- markdownlint-restore -->
<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_artifactory"></a> [artifactory](#requirement\_artifactory) | >= 10 |
| <a name="requirement_context"></a> [context](#requirement\_context) | >= 0.0.0 |
| <a name="requirement_restapi"></a> [restapi](#requirement\_restapi) | >= 1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_artifactory"></a> [artifactory](#provider\_artifactory) | >= 10 |
| <a name="provider_context"></a> [context](#provider\_context) | >= 0.0.0 |
| <a name="provider_restapi"></a> [restapi](#provider\_restapi) | >= 1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [restapi_object.write_kv_pair](https://registry.terraform.io/providers/Mastercard/restapi/latest/docs/resources/object) | resource |
| [artifactory_file.read_kv_pair](https://registry.terraform.io/providers/jfrog/artifactory/latest/docs/data-sources/file) | data source |
| [artifactory_file.read_kv_path_file](https://registry.terraform.io/providers/jfrog/artifactory/latest/docs/data-sources/file) | data source |
| [artifactory_file_list.read_kv_path](https://registry.terraform.io/providers/jfrog/artifactory/latest/docs/data-sources/file_list) | data source |
| [context_config.this](https://registry.terraform.io/providers/cloudposse/context/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_artifactory_auth_token"></a> [artifactory\_auth\_token](#input\_artifactory\_auth\_token) | The authentication token to use when accessing artifactory. Getting this value from the environment is supported<br/>with JFROG\_ACCESS\_TOKEN or ARTIFACTORY\_ACCESS\_TOKEN variables. | `string` | n/a | yes |
| <a name="input_artifactory_base_uri"></a> [artifactory\_base\_uri](#input\_artifactory\_base\_uri) | The base URI for artifactory. | `string` | n/a | yes |
| <a name="input_artifactory_repository"></a> [artifactory\_repository](#input\_artifactory\_repository) | The name of the artifactory repository. | `string` | n/a | yes |
| <a name="input_get"></a> [get](#input\_get) | A map of keys to read from the key/value store. The key\_path, namespace,<br/>tenant, stage, environment, and name are derived from context by default,<br/>but can be overridden by specifying a value in the map. | <pre>map(object(<br/>    {<br/>      key_path   = optional(string),<br/>      properties = optional(map(string))<br/>    }<br/>    )<br/>  )</pre> | `{}` | no |
| <a name="input_get_by_path"></a> [get\_by\_path](#input\_get\_by\_path) | A map of keys to read from the key/value store. The key\_path, namespace,<br/>tenant, stage, environment, and name are derived from context by default,<br/>but can be overridden by specifying a value in the map. | <pre>map(object(<br/>    {<br/>      key_path   = optional(string),<br/>      properties = optional(map(string))<br/>    }<br/>    )<br/>  )</pre> | `{}` | no |
| <a name="input_key_label_order"></a> [key\_label\_order](#input\_key\_label\_order) | The order in which the labels (ID elements) appear in the full key path. For example, if you want a key path to<br/>look like /{namespace}/{tenant}/{stage}/{environment}/name, you would set this varibale to<br/>["namespace", "tenant", "stage", "environment", "name"]. | `list(string)` | n/a | yes |
| <a name="input_key_prefix"></a> [key\_prefix](#input\_key\_prefix) | The prefix to use for the key path. This is useful for storing all keys for a module under a common prefix. | `string` | `""` | no |
| <a name="input_set"></a> [set](#input\_set) | A map of key-value pairs to write to the key/value store. The key\_path,<br/>namespace, tenant, stage, environment, and name are derived from context by<br/>default, but can be overridden by specifying a value in the map. | <pre>map(object(<br/>    {<br/>      key_path   = optional(string),<br/>      value      = string,<br/>      sensitive  = bool,<br/>      properties = optional(map(string))<br/>    }<br/>    )<br/>  )</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_values"></a> [values](#output\_values) | the values retrieved with the kv store |
<!-- markdownlint-restore -->


## Related Projects

Check out these related projects.

- [terraform-null-label](https://github.com/cloudposse/terraform-null-label) - Terraform module designed to generate consistent names and tags for resources. Use terraform-null-label to implement a strict naming convention.


## References

For additional context, refer to some of these links.




> [!TIP]
> #### Use Terraform Reference Architectures for AWS
>
> Use Cloud Posse's ready-to-go [terraform architecture blueprints](https://cloudposse.com/reference-architecture/) for AWS to get up and running quickly.
>
> ✅ We build it together with your team.<br/>
> ✅ Your team owns everything.<br/>
> ✅ 100% Open Source and backed by fanatical support.<br/>
>
> <a href="https://cpco.io/commercial-support?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-artifactory-kv-store&utm_content=commercial_support"><img alt="Request Quote" src="https://img.shields.io/badge/request%20quote-success.svg?style=for-the-badge"/></a>
> <details><summary>📚 <strong>Learn More</strong></summary>
>
> <br/>
>
> Cloud Posse is the leading [**DevOps Accelerator**](https://cpco.io/commercial-support?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-artifactory-kv-store&utm_content=commercial_support) for funded startups and enterprises.
>
> *Your team can operate like a pro today.*
>
> Ensure that your team succeeds by using Cloud Posse's proven process and turnkey blueprints. Plus, we stick around until you succeed.
> #### Day-0:  Your Foundation for Success
> - **Reference Architecture.** You'll get everything you need from the ground up built using 100% infrastructure as code.
> - **Deployment Strategy.** Adopt a proven deployment strategy with GitHub Actions, enabling automated, repeatable, and reliable software releases.
> - **Site Reliability Engineering.** Gain total visibility into your applications and services with Datadog, ensuring high availability and performance.
> - **Security Baseline.** Establish a secure environment from the start, with built-in governance, accountability, and comprehensive audit logs, safeguarding your operations.
> - **GitOps.** Empower your team to manage infrastructure changes confidently and efficiently through Pull Requests, leveraging the full power of GitHub Actions.
>
> <a href="https://cpco.io/commercial-support?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-artifactory-kv-store&utm_content=commercial_support"><img alt="Request Quote" src="https://img.shields.io/badge/request%20quote-success.svg?style=for-the-badge"/></a>
>
> #### Day-2: Your Operational Mastery
> - **Training.** Equip your team with the knowledge and skills to confidently manage the infrastructure, ensuring long-term success and self-sufficiency.
> - **Support.** Benefit from a seamless communication over Slack with our experts, ensuring you have the support you need, whenever you need it.
> - **Troubleshooting.** Access expert assistance to quickly resolve any operational challenges, minimizing downtime and maintaining business continuity.
> - **Code Reviews.** Enhance your team’s code quality with our expert feedback, fostering continuous improvement and collaboration.
> - **Bug Fixes.** Rely on our team to troubleshoot and resolve any issues, ensuring your systems run smoothly.
> - **Migration Assistance.** Accelerate your migration process with our dedicated support, minimizing disruption and speeding up time-to-value.
> - **Customer Workshops.** Engage with our team in weekly workshops, gaining insights and strategies to continuously improve and innovate.
>
> <a href="https://cpco.io/commercial-support?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-artifactory-kv-store&utm_content=commercial_support"><img alt="Request Quote" src="https://img.shields.io/badge/request%20quote-success.svg?style=for-the-badge"/></a>
> </details>

## ✨ Contributing

This project is under active development, and we encourage contributions from our community.



Many thanks to our outstanding contributors:

<a href="https://github.com/cloudposse/terraform-artifactory-kv-store/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=cloudposse/terraform-artifactory-kv-store&max=24" />
</a>

For 🐛 bug reports & feature requests, please use the [issue tracker](https://github.com/cloudposse/terraform-artifactory-kv-store/issues).

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.
 1. Review our [Code of Conduct](https://github.com/cloudposse/terraform-artifactory-kv-store/?tab=coc-ov-file#code-of-conduct) and [Contributor Guidelines](https://github.com/cloudposse/.github/blob/main/CONTRIBUTING.md).
 2. **Fork** the repo on GitHub
 3. **Clone** the project to your own machine
 4. **Commit** changes to your own branch
 5. **Push** your work back up to your fork
 6. Submit a **Pull Request** so that we can review your changes

**NOTE:** Be sure to merge the latest changes from "upstream" before making a pull request!

### 🌎 Slack Community

Join our [Open Source Community](https://cpco.io/slack?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-artifactory-kv-store&utm_content=slack) on Slack. It's **FREE** for everyone! Our "SweetOps" community is where you get to talk with others who share a similar vision for how to rollout and manage infrastructure. This is the best place to talk shop, ask questions, solicit feedback, and work together as a community to build totally *sweet* infrastructure.

### 📰 Newsletter

Sign up for [our newsletter](https://cpco.io/newsletter?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-artifactory-kv-store&utm_content=newsletter) and join 3,000+ DevOps engineers, CTOs, and founders who get insider access to the latest DevOps trends, so you can always stay in the know.
Dropped straight into your Inbox every week — and usually a 5-minute read.

### 📆 Office Hours <a href="https://cloudposse.com/office-hours?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-artifactory-kv-store&utm_content=office_hours"><img src="https://img.cloudposse.com/fit-in/200x200/https://cloudposse.com/wp-content/uploads/2019/08/Powered-by-Zoom.png" align="right" /></a>

[Join us every Wednesday via Zoom](https://cloudposse.com/office-hours?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-artifactory-kv-store&utm_content=office_hours) for your weekly dose of insider DevOps trends, AWS news and Terraform insights, all sourced from our SweetOps community, plus a _live Q&A_ that you can’t find anywhere else.
It's **FREE** for everyone!
## License

<a href="https://opensource.org/licenses/Apache-2.0"><img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg?style=for-the-badge" alt="License"></a>

<details>
<summary>Preamble to the Apache License, Version 2.0</summary>
<br/>
<br/>

Complete license is available in the [`LICENSE`](LICENSE) file.

```text
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
```
</details>

## Trademarks

All other trademarks referenced herein are the property of their respective owners.


## Copyrights

Copyright © 2024-2024 [Cloud Posse, LLC](https://cloudposse.com)



<a href="https://cloudposse.com/readme/footer/link?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-artifactory-kv-store&utm_content=readme_footer_link"><img alt="README footer" src="https://cloudposse.com/readme/footer/img"/></a>

<img alt="Beacon" width="0" src="https://ga-beacon.cloudposse.com/UA-76589703-4/cloudposse/terraform-artifactory-kv-store?pixel&cs=github&cm=readme&an=terraform-artifactory-kv-store"/>
