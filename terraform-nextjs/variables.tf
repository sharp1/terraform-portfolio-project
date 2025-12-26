variable "region" {
  type        = string
  description = "AWS region to deploy into"
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = "AWS CLI profile to use"
  default     = "marquis-admin"
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name for the website (must be globally unique)"
  default     = "marquis-nextjs-portfolio-12345"
}

variable "environment" {
  type        = string
  description = "Environment tag value"
  default     = "Production"
}
