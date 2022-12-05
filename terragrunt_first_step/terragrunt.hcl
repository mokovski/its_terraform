remote_state{
    backend  = "s3"
    generate = {
        path      = "backend.tf"
        if_exists = "overwrite"
    }

    config = {
        bucket         = "aws-terraform-state-backend-testing"
        region         = "eu-central-1"
        key            = "${path_relative_to_include()}/terraform.tfstate"
        encrypt        = true
        dynamodb_table = "terragrunt-states-backend-testing"
    }
}


generate "provider" {
    path      = "provider.tf"
    if_exists = "overwrite"

    contents = <<EOF
provider "aws" {
    region = var.aws_region
    default_tags {
        tags = var.default_tags
    }
}
variable "aws_region" {
    description = "AWS Region."
}
variable "default_tags" {
    type        = map(string)
    description = "Default tags for AWS"
}
EOF
}

locals {
    aws_region        = "eu-central-1"
    deployment_prefix = "test-terragrunt"
}

inputs = {
    aws_region         = local.aws_region
    deployment_prefix  = local.deployment_prefix
    default_tags       = { 
        Env = "Prod"
    }
}
