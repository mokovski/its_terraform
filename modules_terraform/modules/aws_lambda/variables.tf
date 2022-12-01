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

variable "tags" {
    type    = map(any)
    default = {}
}
