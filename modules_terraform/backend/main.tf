terraform {
    backend "s3" {
        bucket         = "aws-terraform-state-backend-for-signify"
        key            = "backend/terraform.tfstate"
        region         = "eu-central-1"
        dynamodb_table = "aws-terraform-state-locks"
        encrypt        = false
    }

}
# Create a dynamodb table for locking the state file
resource "aws_dynamodb_table" "terraform_state_locks" {
    name         = var. dynamodb_table
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    tags = {
        "Name"        = var.dynamodb_table
        "Description" = "DynamoDB terraform table to lock states"
    }
}
# Create an S3 bucket to store the state file in
resource "aws_s3_bucket"  "terraform_state" {
    bucket = var.state_bucket
    versioning {
        enabled = false
    }
    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
    object_lock_configuration {
        object_lock_enabled = "Enabled"
    }
    lifecycle {
        prevent_destroy = false
    }
    tags = {
        Name = var.state_bucket
        Description = "S3 Remote Terraform State Store"
    }
}

resource "aws_s3_bucket_public_access_block" "s3_access_block" {
    bucket                  = aws_s3_bucket.terraform_state.id
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}