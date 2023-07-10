# Config recorder module
Config recorder module to record all modifications done to all the resources.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_config_configuration_recorder.recorder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder) | resource |
| [aws_config_configuration_recorder_status.enable_recorder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder_status) | resource |
| [aws_config_delivery_channel.s3_delivery_chanel](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_delivery_channel) | resource |
| [aws_iam_role.recorder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.recorder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.managed_policy_recorder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.recorder_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.block_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_recorder_name"></a> [recorder\_name](#input\_recorder\_name) | AWS config Recorder name | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | AWS Recorder s3 destination. In order to put the modifications. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_recorder_delivery_channel"></a> [recorder\_delivery\_channel](#output\_recorder\_delivery\_channel) | AWS config recorder delivery channel |
| <a name="output_recorder_name"></a> [recorder\_name](#output\_recorder\_name) | AWS config Recorder arn |
| <a name="output_role_arn_policy_id"></a> [role\_arn\_policy\_id](#output\_role\_arn\_policy\_id) | AWS config Recorder policy |
| <a name="output_role_arn_recorder"></a> [role\_arn\_recorder](#output\_role\_arn\_recorder) | AWS config Recorder policy |
| <a name="output_s3_bucket"></a> [s3\_bucket](#output\_s3\_bucket) | s3 bucket name AWS config modfications |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | s3 bucket arn for AWS config modfications |
