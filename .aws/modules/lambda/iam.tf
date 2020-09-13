data "aws_iam_policy_document" "lambda_execution_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_execution" {
  name = "${local.resource_namespace}-lambda-execution-role"

  assume_role_policy = data.aws_iam_policy_document.lambda_execution_assume_role.json

  force_detach_policies = true
}

data "aws_iam_policy_document" "cloudwatch_logs" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }

  statement {
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:ReEncrypt*",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "cloudwatch_write_permission" {
  name = "${local.resource_namespace}-cloudwatch-write-policy"
  path = "/"

  policy = data.aws_iam_policy_document.cloudwatch_logs.json
}

resource "aws_iam_policy_attachment" "cloudwatch_write_permission_attachment" {
  name = "${local.resource_namespace}-cloudwatch-policy-attachment"

  roles = [aws_iam_role.lambda_execution.name]

  policy_arn = aws_iam_policy.cloudwatch_write_permission.arn
}
