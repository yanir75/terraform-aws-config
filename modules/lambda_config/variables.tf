variable "ses_arn" {
  description = "SES arn"
  type = string
}

variable "recipients" {
  description = "Email recipients"
  type = string
}

variable "sender" {
  description = "Email of the sender"
  type = string
}

variable "lambda_name" {
  description = "Lambda name"
  type = string
}

variable "timeout" {
  description = "Lambda timeout"
  type = number
  default = 60
}

variable "handler" {
  description = "Lambda handler"
  type = string
  default = "config_reporter.config_reporter"
}

variable "runtime" {
  description = "Lambda runtime"
  type = string
  default = "python3.8"
}

variable "path" {
  type = string
  description = "Path to lambda zip"
}

variable "aggregator_name" {
  type = string
  description = "AWS config aggregator name"
}