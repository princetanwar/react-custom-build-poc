
resource "aws_cloudfront_origin_access_control" "my_website" {
  name                              = "oac_for_s3"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}



resource "aws_cloudfront_distribution" "cf_distribution" {
  depends_on = [
    aws_cloudfront_origin_access_control.my_website
  ]
  enabled = true
  #   default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.bucket_id
    viewer_protocol_policy = "https-only"


    function_association {
      event_type   = "viewer-request"
      function_arn = var.viewer_function_arn
    }

    min_ttl     = 1
    default_ttl = 3600  # one hour
    max_ttl     = 86400 # one day
    compress    = true

    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }

  }
  origin {
    domain_name              = var.bucket_domain_name
    origin_id                = var.bucket_id
    origin_access_control_id = aws_cloudfront_origin_access_control.my_website.id

  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }

  }
  viewer_certificate {
    cloudfront_default_certificate = true

  }

}


