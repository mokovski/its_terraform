data "archive_file" "aws_lambda" {
  type        = "zip"
  source_file = "${var.python_dir}/${var.aws_lambda-function_name}.py"
  output_path = "${var.python_dir}/${var.aws_lambda-function_name}.zip"
}


locals {
  environment_map = var.aws_lambda-env_vars[*]
}

resource "aws_lambda_function" "lambda_creator" {
  filename      = data.archive_file.aws_lambda.output_path
  function_name = "${var.aws_lambda-resource_name_prefix}-${var.aws_lambda-function_name}"
  role          = aws_iam_role.lambda_role.arn
  handler       = "${var.aws_lambda-function_name}.lambda_handler"
  source_code_hash = data.archive_file.aws_lambda.output_base64sha256
  runtime = "python3.7"
  timeout = 100
  dynamic "environment" {
    for_each = local.environment_map
    content {
      variables = environment.value
    }
  }
  # tags = merge(map("Name", "${var.aws_lambda-resource_name_prefix}-${var.aws_lambda-function_name}-lambda"), var.tags)
}