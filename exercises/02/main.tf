# main.tf

# Declare the provider being used, in this case it's AWS.
# This provider supports setting the provider version, AWS credentials as well as the region.
# It can also pull credentials and the region to use from environment variables, which we have set, so we'll use those
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

locals {
  bucket_name = "sm-di-${var.student_alias}"
}

# declare a resource stanza so we can create something.
resource "aws_s3_bucket_object" "user_student_alias_object" {
  bucket  = local.bucket_name
  key     = "student.alias"
  content = "This bucket is reserved for ${var.student_alias}"
}
