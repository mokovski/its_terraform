terraform {
    backend "s3" {
        bucket         = "aws-terraform-state-backend-testing"
        key            = "aws_s3/terraform.tfstate"
        region         = "eu-central-1"
        dynamodb_table = "aws-terraform-state-locks"
        encrypt        = false
    }

}