# terraform-aws-config
Sends daily AWS resource modification summary of your AWS account to your email.  
EventBridge triggers a lambda which sends a report of your daily AWS modification to you inbox, in order to track and remediate daily changes.  
Tracks all available services and resources.


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.56.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda_send_report"></a> [lambda\_send\_report](#module\_lambda\_send\_report) | ./modules/lambda_config | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.daily_report_time](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.daily_report](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_config_aggregate_authorization.account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_aggregate_authorization) | resource |
| [aws_config_configuration_aggregator.account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_aggregator) | resource |
| [aws_config_configuration_recorder.recorder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder) | resource |
| [aws_config_configuration_recorder_status.enable_recorder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder_status) | resource |
| [aws_config_delivery_channel.s3_delivery_chanel](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_delivery_channel) | resource |
| [aws_iam_role.recorder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.recorder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.managed_policy_recorder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_permission.daily_report_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket.recorder_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.block_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_ses_email_identity.daily_report_email](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_email_identity) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_regions.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aggregator_name"></a> [aggregator\_name](#input\_aggregator\_name) | Name of the AWS config aggregator name | `string` | n/a | yes |
| <a name="input_event_description"></a> [event\_description](#input\_event\_description) | Eventbridge event description | `string` | n/a | yes |
| <a name="input_event_name"></a> [event\_name](#input\_event\_name) | Eventbridge event name | `string` | n/a | yes |
| <a name="input_lambda_name"></a> [lambda\_name](#input\_lambda\_name) | Lambda function name | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | Path to the source folder of the lambda code | `string` | n/a | yes |
| <a name="input_profile"></a> [profile](#input\_profile) | AWS profile to use | `string` | n/a | yes |
| <a name="input_recipient"></a> [recipient](#input\_recipient) | Which emails to send the report | `string` | n/a | yes |
| <a name="input_recorder_name"></a> [recorder\_name](#input\_recorder\_name) | AWS config Recorder name | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region to deploy | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | AWS Recorder s3 destination. In order to put the modifications. | `string` | n/a | yes |
| <a name="input_schedule_expression"></a> [schedule\_expression](#input\_schedule\_expression) | When to generate the report for example cron(0 0 * * ? *) each day at 12 | `string` | n/a | yes |
| <a name="input_ses_email"></a> [ses\_email](#input\_ses\_email) | Sender email in order to send the report | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_id"></a> [account\_id](#output\_account\_id) | AWS Account id |
| <a name="output_aggregator_arn"></a> [aggregator\_arn](#output\_aggregator\_arn) | AWS config Aggregator arn |
| <a name="output_authorization_arns"></a> [authorization\_arns](#output\_authorization\_arns) | AWS config Authorization arns |
| <a name="output_event_arn"></a> [event\_arn](#output\_event\_arn) | event bridge event arn |
| <a name="output_event_name"></a> [event\_name](#output\_event\_name) | event bridge event arn |
| <a name="output_lambda_arn"></a> [lambda\_arn](#output\_lambda\_arn) | lambda arn |
| <a name="output_lambda_log_group_arn"></a> [lambda\_log\_group\_arn](#output\_lambda\_log\_group\_arn) | Log group arn |
| <a name="output_lambda_log_group_retention_period"></a> [lambda\_log\_group\_retention\_period](#output\_lambda\_log\_group\_retention\_period) | Log group arn |
| <a name="output_lambda_name"></a> [lambda\_name](#output\_lambda\_name) | lambda name |
| <a name="output_lambda_policy_arns"></a> [lambda\_policy\_arns](#output\_lambda\_policy\_arns) | Policy arns |
| <a name="output_lambda_role_arn"></a> [lambda\_role\_arn](#output\_lambda\_role\_arn) | Lambda role arn |
| <a name="output_recorder_delivery_channel"></a> [recorder\_delivery\_channel](#output\_recorder\_delivery\_channel) | AWS config recorder delivery channel |
| <a name="output_recorder_name"></a> [recorder\_name](#output\_recorder\_name) | AWS config Recorder arn |
| <a name="output_regions"></a> [regions](#output\_regions) | Regions which the AWS aggregator utilize |
| <a name="output_role_arn_policy_id"></a> [role\_arn\_policy\_id](#output\_role\_arn\_policy\_id) | AWS config Recorder policy |
| <a name="output_role_arn_recorder"></a> [role\_arn\_recorder](#output\_role\_arn\_recorder) | AWS config Recorder policy |
| <a name="output_s3_bucket"></a> [s3\_bucket](#output\_s3\_bucket) | s3 bucket name AWS config modfications |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | s3 bucket arn for AWS config modfications |
| <a name="output_ses_email"></a> [ses\_email](#output\_ses\_email) | SES sender email |
| <a name="output_ses_email_arn"></a> [ses\_email\_arn](#output\_ses\_email\_arn) | Simple Email Service (SES) arn |