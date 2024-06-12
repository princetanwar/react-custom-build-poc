output "bucket_name" {
  value = aws_s3_bucket.my_storage_bucket.bucket
}
output "bucket_id" {
  value = aws_s3_bucket.my_storage_bucket.id
}
output "bucket_domain_name" {
  value = aws_s3_bucket.my_storage_bucket.bucket_regional_domain_name
}
