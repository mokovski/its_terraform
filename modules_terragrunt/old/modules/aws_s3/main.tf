locals {
  allowed_headers = try(var.s3_bucket-cors_rule.allowed_headers, null)
  expose_headers  = try(var.s3_bucket-cors_rule.expose_headers, null)
  max_age_seconds = try(var.s3_bucket-cors_rule.max_age_seconds, null)
}

resource "aws_s3_bucket" "this" {
  bucket        = var.s3_bucket-name
  acl           = var.s3_bucket-acl
  policy        = var.s3_bucket-policy

  dynamic "cors_rule" { 
    for_each = length(var.s3_bucket-cors_rule) > 0 ? [1] : []
    content {
      allowed_headers = local.allowed_headers
      allowed_methods = var.s3_bucket-cors_rule.allowed_methods
      allowed_origins = var.s3_bucket-cors_rule.allowed_origins
      expose_headers  = local.expose_headers
      max_age_seconds = local.max_age_seconds
    }
  }

  dynamic "website" {
    for_each = length(var.website) > 0 ? [1] : []
    content {
      index_document = var.website.index_document
    }
  }
  force_destroy = var.s3_force_destroy

  # tags = merge(map("Name", var.s3_bucket-name), var.tags)

  versioning {
    enabled = var.s3_bucket-versioning
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  count  = var.s3_bucket-block_public_access == true ? 1 : 0
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_object" "empty_folders" {
  count  = length(var.s3_empty_folders) > 0 ? length(var.s3_empty_folders) : 0
  bucket = aws_s3_bucket.this.id
  acl    = lookup(var.s3_empty_folders[count.index], "acl", var.s3_bucket-acl)
  key    = lookup(var.s3_empty_folders[count.index], "folder_name")
  source = "/dev/null"
}
