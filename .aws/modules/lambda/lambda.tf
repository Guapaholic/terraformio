locals {
  hello_world_file_path     = "${path.module}/../../../functions/src/index.js"
  hello_world_artifact_path = "${path.module}/assets/hello-world.zip"
  lambda_name               = "${local.resource_namespace}-hello-world"
}

data "archive_file" "hello_world_artifact" {
  type        = "zip"
  output_path = local.hello_world_artifact_path

  source {
    content  = file(local.hello_world_file_path)
    filename = "index.js"
  }
}

resource "aws_lambda_function" "hello_guapaholic" {
  filename      = data.archive_file.hello_world_artifact.output_path
  function_name = local.lambda_name
  role          = aws_iam_role.lambda_execution.arn

  handler = "index.handler"

  runtime = "nodejs12.x"

  source_code_hash = data.archive_file.hello_world_artifact.output_base64sha256

  tags = merge({ function_name = local.lambda_name }, local.common_tags)

  depends_on = [
    aws_iam_policy_attachment.cloudwatch_write_permission_attachment
  ]
}
