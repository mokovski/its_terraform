terraform {
    backend "s3" {
        bucket         = "aws-terraform-state-backend-for-signify"
        key            = "backend/terraform.tfstate"
        region         = "eu-central-1"
        dynamodb_table = "aws-terraform-state-locks"
        encrypt        = false
    }

}