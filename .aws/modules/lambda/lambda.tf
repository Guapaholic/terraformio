locals {
  lambda_file_path = "${path.module}/../../../functions/src/index.js"
  lambda_name = "${local.resource_namespace}-hello-world"
}

resource "aws_lambda_function" "hello_guapaholic" {
  filename = local.lambda_file_path
  function_name = local.lambda_name
  role = aws_iam_role.lambda_execution.arn

  handler = "index.handler"
  
  runtime = "nodejs12.x"

  source_code_hash = filemd5(local.lambda_file_path)

  tags = merge({ function_name = local.lambda_name }, local.common_tags)

  depends_on = [
    aws_iam_policy_attachment.cloudwatch_write_permission_attachment
  ]
}
