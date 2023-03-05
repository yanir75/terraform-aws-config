data "aws_caller_identity" "current" {}
data "aws_regions" "current" {
  count = var.is_main_region ? 1 : 0
}

locals {
  account_id = data.aws_caller_identity.current.account_id
  regions    = var.is_main_region ? data.aws_regions.current[0].names : null
}
resource "aws_config_configuration_aggregator" "account" {
  count = var.is_main_region ? 1 : 0
  name  = var.aggregator_name

  account_aggregation_source {
    account_ids = [local.account_id]
    regions     = local.regions
  }
}

resource "aws_config_aggregate_authorization" "account" {
  for_each   = var.is_main_region ? local.regions : toset([])
  account_id = local.account_id
  region     = each.key
}

resource "aws_ses_email_identity" "daily_report_email" {
  count = var.is_main_region ? 1 : 0
  email = var.ses_email
}


resource "aws_cloudwatch_event_rule" "daily_report_time" {
  count               = var.is_main_region ? 1 : 0
  name                = var.event_name
  description         = var.event_description
  schedule_expression = var.schedule_expression
}

module "lambda_send_report" {
  count           = var.is_main_region ? 1 : 0
  source          = "./modules/lambda_config"
  sender          = var.ses_email
  aggregator_name = aws_config_configuration_aggregator.account[0].name
  recipients      = var.recipient
  ses_arn         = aws_ses_email_identity.daily_report_email[0].arn
  lambda_name     = var.lambda_name
  path            = var.path
}



resource "aws_cloudwatch_event_target" "daily_report" {
  count = var.is_main_region ? 1 : 0
  arn   = module.lambda_send_report[0].lambda_arn
  rule  = aws_cloudwatch_event_rule.daily_report_time[0].name
}

resource "aws_lambda_permission" "daily_report_permissions" {
  count         = var.is_main_region ? 1 : 0
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_send_report[0].lambda_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.daily_report_time[0].arn
}

module "recorder" {
  source         = "./modules/config_recorder"
  recorder_name  = var.recorder_name
  s3_bucket_name = var.s3_bucket_name
}