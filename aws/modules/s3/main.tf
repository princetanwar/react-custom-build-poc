
resource "aws_s3_bucket" "my_storage_bucket" {
  bucket = "custom-build-react-website"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}


