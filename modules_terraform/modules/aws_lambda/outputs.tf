output "aws_lambda-name" {
  value = aws_lambda_function.lambda_creator.function_name
}

output "aws_lambda-invoke_arn" {
  value = aws_lambda_function.lambda_creator.invoke_arn
}

output "aws_lambda-arn" {
  value = aws_lambda_function.lambda_creator.arn
}