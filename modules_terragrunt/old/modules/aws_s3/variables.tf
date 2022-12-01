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

variable "tags" {
  default = {}
}

variable "website" {
  default = ""
}
