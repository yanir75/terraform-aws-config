output "aggregator_arn" {
  value       = var.is_main_region ? aws_config_configuration_aggregator.account[0].arn : null
  description = "AWS config Aggregator arn"
}

output "authorization_arns" {
  description = "AWS config Authorization arns"
  value       = var.is_main_region ? [for auth in aws_config_aggregate_authorization.account : auth.arn] : null
}

output "account_id" {
  description = "AWS Account id"
  value       = local.account_id
}

output "regions" {
  description = "Regions which the AWS aggregator utilize"
  value       = local.regions
}

output "ses_email_arn" {
  description = "Simple Email Service (SES) arn"
  value       = var.is_main_region ? aws_ses_email_identity.daily_report_email[0].arn : null
}

output "ses_email" {
  description = "SES sender email"
  value       = var.is_main_region ? aws_ses_email_identity.daily_report_email[0].email : null
}

output "event_arn" {
  description = "event bridge event arn"
  value       = var.is_main_region ? aws_cloudwatch_event_rule.daily_report_time[0].arn : null
}

output "event_name" {
  description = "event bridge event arn"
  value       = var.is_main_region ? aws_cloudwatch_event_rule.daily_report_time[0].name : null
}

output "role_arn_recorder" {
  description = "AWS config Recorder policy"
  value       = module.recorder.role_arn_recorder
}

output "role_arn_policy_id" {
  description = "AWS config Recorder policy"
  value       = module.recorder.role_arn_policy_id
}

output "recorder_name" {
  description = "AWS config Recorder arn"
  value       = module.recorder.recorder_name
}

output "s3_bucket" {
  description = "s3 bucket name AWS config modfications"
  value       = module.recorder.s3_bucket
}

output "s3_bucket_arn" {
  description = "s3 bucket arn for AWS config modfications"
  value       = module.recorder.s3_bucket_arn
}

output "recorder_delivery_channel" {
  description = "AWS config recorder delivery channel"
  value       = module.recorder.recorder_delivery_channel
}

### lambda module outputs

output "lambda_policy_arns" {
  description = "Policy arns"
  value       = var.is_main_region ? module.lambda_send_report[0].policy_arns : null
}

output "lambda_role_arn" {
  description = "Lambda role arn"
  value       = var.is_main_region ? module.lambda_send_report[0].role_arn : null
}

output "lambda_log_group_arn" {
  description = "Log group arn"
  value       = var.is_main_region ? module.lambda_send_report[0].log_group_arn : null
}

output "lambda_log_group_retention_period" {
  description = "Log group arn"
  value       = var.is_main_region ? module.lambda_send_report[0].log_group_retention_period : null
}

output "lambda_arn" {
  description = "lambda arn"
  value       = var.is_main_region ? module.lambda_send_report[0].lambda_arn : null
}

output "lambda_name" {
  description = "lambda name"
  value       = var.is_main_region ? module.lambda_send_report[0].lambda_name : null
}