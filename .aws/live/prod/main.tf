terraform {
  backend "s3" {
    bucket = "083959723813-terraform-state"
    key    = "terraformio/state/account"
  }
}

module "lambda" {
  source = "../../modules/lambda"

  stage = "prod"
}
