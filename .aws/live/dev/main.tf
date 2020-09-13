terraform {
  backend "s3" {
    bucket = "083959723813-terraform-state"
    key    = "terraformio/state/account"
    region = "us-east-1"
  }
}

module "lambda" {
  source = "../../modules/lambda"

  stage = "dev"
}
