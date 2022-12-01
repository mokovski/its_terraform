include "root" {
    path = find_in_parent_folders()
}

terraform {
    source = "."
}

inputs = {
    s3_bucket-name                = "testing-project-terragrung"
    s3_empty_folders              = []
    s3_bucket-acl                 = "private"
    s3_bucket-block_public_access = true
    s3_bucket-policy              = ""
    s3_bucket-cors_rule           = {}
    s3_bucket-versioning          = false
    s3_force_destroy              = false
    website                       = ""
}