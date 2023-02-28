output "aggregator_arn" {
  value       = aws_config_configuration_aggregator.account.arn
  description = "AWS config Aggregator arn"
}

output "authorization_arns" {
  description = "AWS config Authorization arns"
  value       = [for auth in aws_config_aggregate_authorization.account : auth.arn]
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
  value       = aws_ses_email_identity.daily_report_email.arn
}

output "ses_email" {
  description = "SES sender email"
  value       = aws_ses_email_identity.daily_report_email.email
}

output "event_arn" {
  description = "event bridge event arn"
  value       = aws_cloudwatch_event_rule.daily_report_time.arn
}

output "event_name" {
  description = "event bridge event arn"
  value       = aws_cloudwatch_event_rule.daily_report_time.name
}

output "role_arn_recorder" {
  description = "AWS config Recorder policy"
  value       = aws_iam_role.recorder.arn
}

output "role_arn_policy_id" {
  description = "AWS config Recorder policy"
  value       = aws_iam_role_policy.recorder.id
}

output "recorder_name" {
  description = "AWS config Recorder arn"
  value       = aws_config_configuration_recorder.recorder.name
}

output "s3_bucket" {
  description = "s3 bucket name AWS config modfications"
  value       = aws_s3_bucket.recorder_bucket.bucket
}

output "s3_bucket_arn" {
  description = "s3 bucket arn for AWS config modfications"
  value       = aws_s3_bucket.recorder_bucket.arn
}

output "recorder_delivery_channel" {
  description = "AWS config recorder delivery channel"
  value       = aws_config_delivery_channel.s3_delivery_chanel.id
}

### lambda module outputs

output "lambda_policy_arns" {
  description = "Policy arns"
  value       = module.lambda.policy_arns
}

output "lambda_role_arn" {
  description = "Lambda role arn"
  value       = module.lambda.role_arn
}

output "lambda_log_group_arn" {
  description = "Log group arn"
  value       = module.lambda.log_group_arn
}

output "lambda_log_group_retention_period" {
  description = "Log group arn"
  value       = module.lambda.log_group_retention_period
}

output "lambda_arn" {
  description = "lambda arn"
  value       = module.lambda.lambda_arn
}

output "lambda_name" {
  description = "lambda name"
  value       = module.lambda.lambda_name
}