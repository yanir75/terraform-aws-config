variable "region" {
  description = "AWS region to deploy"
  type = string
}

variable "profile" {
  description = "AWS profile to use"
  type = string
}

variable "aggregator_name" {
  description = "Aggregator name"
  type = string
}

variable "ses_email" {
  description = "Email to use"
  type = string
}

variable "event_name" {
  description = "Event name" 
  type = string
}

variable "event_description" {
  description = "Event description"
  type = string
}

variable "schedule_expression" {
  description = "When to generate the report"
  type = string
}

variable "recipient" {
  description = "Email recipients"
  type = string
}

variable "lambda_name" {
  description = "Lambda name"
  type = string
}

variable "path" {
  description = "Path to the lambda"
  type = string
}

variable "recorder_name" {
  description = "Recorder name"
  type = string
}

variable "s3_bucket_name" {
  description = "Recorder s3 destination"
  type = string
}

variable "main_region" {
  description = "Is it the main region to deploy"
  type = bool
  default = true
}