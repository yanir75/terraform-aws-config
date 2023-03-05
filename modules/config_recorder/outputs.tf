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
