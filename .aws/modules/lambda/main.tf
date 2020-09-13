data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name

  cloudwatch_namespace = "/${var.stage}/${var.application_name}"
  resource_namespace   = "${var.stage}-${var.application_name}"

  common_tags = {
    service = var.application_name
    stage   = var.stage
  }
}
