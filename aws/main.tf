# configure the provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.53.0"
    }
  }
}

# configure aws credentials
provider "aws" {
  region     = "us-east-2"
  access_key = var.access_key
  secret_key = var.secret_key
}


module "s3_setup" {
  source = "./modules/s3"
}

module "cf_function_setup" {
  source = "./modules/cloudfront_functions"
}

module "cf_setup" {
  depends_on          = [module.s3_setup]
  source              = "./modules/cloudfront"
  bucket_id           = module.s3_setup.bucket_id
  bucket_domain_name  = module.s3_setup.bucket_domain_name
  viewer_function_arn = module.cf_function_setup.viewer_function_arn
}

module "s3_cf_integration" {
  depends_on          = [module.s3_setup, module.cf_setup]
  source              = "./modules/s3_cf_integration"
  bucket_id           = module.s3_setup.bucket_id
  cf_distribution_arn = module.cf_setup.cf_distribution_arn
  bucket_name         = module.s3_setup.bucket_name
}
















