variable "recorder_name" {
  description = "AWS config Recorder name"
  type        = string
}

variable "s3_bucket_name" {
  description = "AWS Recorder s3 destination. In order to put the modifications."
  type        = string
}