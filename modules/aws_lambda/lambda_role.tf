data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_iam_role" "lambda_role" {
  name = "${var.aws_lambda-resource_name_prefix}-${var.aws_lambda-function_name}-lambda-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
  # tags = merge(map("Name", "${var.aws_lambda-resource_name_prefix}-${var.aws_lambda-function_name}-lambda-role"), var.tags)
}

resource "aws_cloudwatch_log_group" "lambda_creator_log" {
  name = "/aws/lambda/${aws_lambda_function.lambda_creator.function_name}"
  retention_in_days = var.log_retention_period
  # tags = merge(map("Name", "${var.aws_lambda-resource_name_prefix}-${var.aws_lambda-function_name}-log-group"), var.tags)
}

resource "aws_iam_role_policy" "lambda_creator_access" {
  name_prefix = "lambda_creator_access"
  role = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.lambda_creator_access_policy.json
}

data "aws_iam_policy_document" "lambda_creator_access_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${aws_lambda_function.lambda_creator.function_name}:*"
    ]
  }
  dynamic "statement" {
    for_each = var.aws_lambda-additional_policy_access
    content {
      effect = "Allow"
      actions = statement.value["actions"]
      resources = statement.value["resources"]
    }
  }
}