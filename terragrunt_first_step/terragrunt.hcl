# remote_state{
#     backend  = "s3"
#     generate = {
#         path      = "backend.tf"
#         if_exists = "overwrite"
#     }

#     config = {
#         bucket         = "aws-terraform-state-backend-testing"
#         region         = "eu-central-1"
#         key            = "${path_relative_to_include()}/terraform.tfstate"
#         encrypt        = true
#         dynamodb_table = "terragrunt-states-backend-testing"
#     }
# }


# generate "provider" {
#     path      = "provider.tf"
#     if_exists = "overwrite"

#     contents = <<EOF
# provider "aws" {
#     region = var.aws_region
#     default_tags {
#         tags = var.default_tags
#     }
# }
# variable "aws_region" {
#     description = "AWS Region."
# }
# variable "default_tags" {
#     type        = map(string)
#     description = "Default tags for AWS"
# }
# EOF
# }

# locals {
#     aws_region        = "eu-central-1"
#     deployment_prefix = "test-terragrunt"
# }

# inputs = {
#     aws_region         = local.aws_region
#     deployment_prefix  = local.deployment_prefix
#     default_tags       = { 
#         Env = "Prod"
#     }
# }

terraform {
  source = "git@github.com:mokovski/its_terraform.git//mokovski/its_terraform/modules/?ref=v0.0.1"
}

inputs = {
    s3_bucket-name                      = ""
    s3_bucket-acl                       = "private"
    s3_bucket-policy                    = ""
    s3_bucket-cors_rule                 = {}
    s3_bucket-versioning                = false
    s3_force_destroy                    = false
    website                             = ""
    aws_lambda-resource_name_prefix     = "testing-project-terragrung"
    aws_lambda-function_name            = "signify"
    aws_lambda-env_vars                 = null
    python_dir                          = "."
    log_retention_period                = 30
}
