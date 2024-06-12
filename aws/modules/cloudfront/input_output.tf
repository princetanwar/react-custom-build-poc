variable "bucket_id" {
  type = string

}

variable "bucket_domain_name" {
  type = string
}

variable "viewer_function_arn" {
  type = string
}



output "cf_distribution_arn" {
  value = aws_cloudfront_distribution.cf_distribution.arn

}
