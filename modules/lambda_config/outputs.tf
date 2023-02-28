output "policy_arns" {
  description = "Policy arns"
  value       = [aws_iam_policy.send_email.arn, aws_iam_policy.get_aggregator.arn, aws_iam_policy.lambda_logging.arn]
}

output "role_arn" {
  description = "Lambda role arn"
  value       = aws_iam_role.iam_for_lambda.arn
}

output "log_group_arn" {
  description = "Log group arn"
  value       = aws_cloudwatch_log_group.lambda_log_group.arn
}

output "log_group_retention_period" {
  description = "Log group arn"
  value       = aws_cloudwatch_log_group.lambda_log_group.retention_in_days
}

output "lambda_arn" {
  description = "lambda arn"
  value       = aws_lambda_function.send_config_lambda.arn
}

output "lambda_name" {
  description = "lambda name"
  value       = aws_lambda_function.send_config_lambda.function_name
}