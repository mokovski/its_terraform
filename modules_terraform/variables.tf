variable "s3_bucket-name" {
    default = ""
}

variable "s3_empty_folders" {
    default = []
}

variable "s3_bucket-acl" {
    default = "private"
}

variable "s3_bucket-block_public_access" {
    default = true
}

variable "s3_bucket-policy" {
    default = ""
}

variable "s3_bucket-cors_rule" {
    type = map(any)
    default = {}
}

variable "s3_bucket-versioning" {
    default = false
}

variable "s3_force_destroy" {
    default = false
}


variable "website" {
    default = ""
}

variable "aws_lambda-resource_name_prefix" {}

variable "aws_lambda-function_name" {}

variable "aws_lambda-env_vars" {
    type = map(string)
    default = null
}

variable "aws_lambda-additional_policy_access" {
    description = "list of object. Each object is a map with 2 keys. actions and resources. each value needs to be a list of each. Example object: { \"actions\" : [\"iam:create*\"], \"resources\": [\"arn:aws:iam::one*\",\"arn:aws:iam::two*\"] }"
    default = []
}

variable "python_dir" {}

variable "log_retention_period" {
    default = 30
}