resource "aws_kms_key" "root" {
  description = "Root CMK"
}

resource "aws_kms_alias" "alias" {
  name          = "alias/${local.resource_namespace}-kms-key"
  target_key_id = aws_kms_key.root.key_id
}
