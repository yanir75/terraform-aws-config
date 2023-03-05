resource "aws_config_configuration_recorder" "recorder" {
  name     = var.recorder_name
  role_arn = aws_iam_role.recorder.arn
  recording_group {
    all_supported                 = true
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