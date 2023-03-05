variable "is_main_region" {
  type = bool
  default = true
  description = "Only in main region we deploy the aggregator and lambda" 
}

variable "region" {
  description = "AWS region to deploy"
  type        = string
}

variable "profile" {
  description = "AWS profile to use"
  type        = string
}

variable "aggregator_name" {
  description = "Name of the AWS config aggregator name"
  type        = string
}

variable "ses_email" {
  description = "Sender email in order to send the report"
  type        = string
}

variable "event_name" {
  description = "Eventbridge event name"
  type        = string
}

variable "event_description" {
  description = "Eventbridge event description"
  type        = string
}

variable "schedule_expression" {
  description = "When to generate the report for example cron(0 0 * * ? *) each day at 12"
  type        = string
}

variable "recipient" {
  description = "Which emails to send the report"
  type        = string
}

variable "lambda_name" {
  description = "Lambda function name"
  type        = string
}

variable "path" {
  description = "Path to the source folder of the lambda code"
  type        = string
}

variable "recorder_name" {
  description = "AWS config Recorder name"
  type        = string
}

variable "s3_bucket_name" {
  description = "AWS Recorder s3 destination. In order to put the modifications."
  type        = string
}