include "root" {
    path = find_in_parent_folders()
}
terraform {
    source = "."
}

inputs = {
    aws_lambda-resource_name_prefix              = "testing-project-terragrung"
    aws_lambda-function_name                     = "terragrunt"
    aws_lambda-env_vars                          = null
    aws_lambda-additional_policy_access          = []
    python_dir                                   = ""
    log_retention_period                         = 30
}