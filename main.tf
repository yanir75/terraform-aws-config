data "aws_caller_identity" "current" {}
data "aws_regions" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  regions = data.aws_regions.current.names
}
resource "aws_config_configuration_aggregator" "account" {
  name = var.aggregator_name

  account_aggregation_source {
    account_ids = [local.account_id]
    regions     = local.regions
  }
}

resource "aws_config_aggregate_authorization" "account" {
  for_each = local.regions
  account_id = local.account_id
  region     = each.key
}

resource "aws_ses_email_identity" "daily_report_email" {
  email = var.ses_email
}


resource "aws_cloudwatch_event_rule" "daily_report_time" {
  name = var.event_name
  description = var.event_description
  schedule_expression = var.schedule_expression
}

module "lambda_send_report" {
  source = "./modules/lambda_config"
  sender = var.ses_email
  aggregator_name = aws_config_configuration_aggregator.account.name
  recipients = var.recipient
  ses_arn = aws_ses_email_identity.daily_report_email.arn
  lambda_name = var.lambda_name
  path = var.path
}



resource "aws_cloudwatch_event_target" "daily_report" {
  arn = module.lambda_send_report.lambda_arn
  rule = aws_cloudwatch_event_rule.daily_report_time.name
}

resource "aws_lambda_permission" "daily_report_permissions" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = module.lambda_send_report.lambda_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.daily_report_time.arn
}


resource "aws_config_configuration_recorder" "recorder" {
  name     = var.recorder_name
  role_arn = aws_iam_role.recorder.arn
  recording_group {
    all_supported = true
    include_global_resource_types = true

  }
}

resource "aws_iam_role" "recorder" {
  name = "${var.recorder_name}Role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}


resource "aws_iam_role_policy" "recorder" {
  name = "${var.s3_bucket_name}RecorderPolicy"
  role = aws_iam_role.recorder.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.recorder_bucket.arn}",
        "${aws_s3_bucket.recorder_bucket.arn}/*"
      ]
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "managed_policy_recorder" {
  role       = aws_iam_role.recorder.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}


resource "aws_config_delivery_channel" "s3_delivery_chanel" {
  name           = "${var.s3_bucket_name}DeliveryChannel"
  s3_bucket_name = aws_s3_bucket.recorder_bucket.bucket
  depends_on     = [aws_config_configuration_recorder.recorder]
}

resource "aws_s3_bucket" "recorder_bucket" {
  bucket        = var.s3_bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.recorder_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_config_configuration_recorder_status" "enable_recorder" {
  name       = aws_config_configuration_recorder.recorder.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.s3_delivery_chanel]
}


