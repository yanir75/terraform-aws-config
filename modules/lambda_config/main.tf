data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "send_email" {
  statement {
    sid = "AllowSendEmail"
    effect = "Allow"
    actions=[
        "ses:SendRawEmail"
    ]

    resources = [
      var.ses_arn,
    ]

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "ses:Recipients"
      values   = [var.recipients]
    }

    condition {
      test     = "StringLike"
      variable = "ses:FromAddress"
      values   = [var.sender]
    }
  }
}

data "aws_iam_policy_document" "get_aggregator" {
  statement {
    sid = "AllowSendEmail"
    effect = "Allow"
    actions=[
        "config:SelectAggregateResourceConfig"
    ]

    resources = [
      "*",
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }
}


resource "aws_iam_policy" "send_email" {
  name   = "${var.lambda_name}SendEmailPolicy"
  path   = "/"
  policy = data.aws_iam_policy_document.send_email.json
}

resource "aws_iam_policy" "get_aggregator" {
  name   = "${var.lambda_name}GetAggregatorPolicy"
  path   = "/"
  policy = data.aws_iam_policy_document.get_aggregator.json
}


resource "aws_iam_role" "iam_for_lambda" {
  name = "${var.lambda_name}Role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "${var.lambda_name}Logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_iam_role_policy_attachment" "send_email" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.send_email.arn
}

resource "aws_iam_role_policy_attachment" "get_aggregator" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.get_aggregator.arn
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.lambda_name}"
  retention_in_days = 14
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir = var.path
  output_path = "lambda_zips/${var.path}.zip"
}

resource "aws_lambda_function" "send_config_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = data.archive_file.lambda_zip.output_path
  function_name = var.lambda_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = var.handler
  timeout = var.timeout

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)

  runtime = var.runtime

  environment {
    variables = {
      AGGREGATOR_NAME = var.aggregator_name
      SENDER = var.sender
      RECIPIENT = var.recipients
    }
  }
}