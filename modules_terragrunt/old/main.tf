module "test_s3" {
    source                              = "./modules/aws_s3"

    s3_bucket-name                      = var.s3_bucket-name
    s3_empty_folders                    = []
    s3_bucket-acl                       = "private"
    s3_bucket-policy                    = var.s3_bucket-policy
    s3_bucket-cors_rule                 = var.s3_bucket-cors_rule
    s3_bucket-versioning                = false
    s3_force_destroy                    = false

}
module "test_lambda" {
    source                              = "./modules/aws_lambda"

    aws_lambda-resource_name_prefix     = var.aws_lambda-resource_name_prefix
    aws_lambda-function_name            = "signify"
    aws_lambda-env_vars                 = var.aws_lambda-env_vars
    aws_lambda-additional_policy_access = []
    python_dir                          = "."
}