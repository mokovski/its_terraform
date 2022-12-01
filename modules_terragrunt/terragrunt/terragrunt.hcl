remote_state{
    backend  = "s3"
    generate = {
        path      = "_backend.tf"
        if_exists = "overwrite"
    }

    config = {
        bucket  = "aws-terraform-state-backend-testing"
        region  = "eu-central-1"
        key     = "${path_relative_to_include()}/terraform.tfstate"
        encrypt = true
    }
}

