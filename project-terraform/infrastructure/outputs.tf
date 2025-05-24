output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of public subnets."
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of private subnets."
  value       = module.vpc.private_subnets
}

output "bucket_name" {
  value = aws_s3_bucket.static_site.id
}

output "cloudfront_domain" {
  value = aws_cloudfront_distribution.cdn.domain_name
}
