
resource "aws_s3_bucket_policy" "my_storage_bucket" {
  depends_on = [data.aws_iam_policy_document.my_website_s3_policy]
  bucket     = var.bucket_id
  policy     = data.aws_iam_policy_document.my_website_s3_policy.json

}


data "aws_iam_policy_document" "my_website_s3_policy" {
  statement {
    sid    = "AllowCloudFrontServicePrincipal"
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    resources = [
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      # values   = [aws_cloudfront_distribution.cf_distribution.arn]
      values = [
        var.cf_distribution_arn
      ]
    }

  }
}
