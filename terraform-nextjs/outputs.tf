output "bucket_name" {
  value       = aws_s3_bucket.nextjs_bucket.bucket
  description = "S3 bucket name hosting the site"
}

output "cloudfront_url" {
  value       = aws_cloudfront_distribution.nextjs_distribution.domain_name
  description = "CloudFront distribution domain"
}
