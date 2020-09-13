variable "application_name" {
  type        = string
  description = "Application name"
  default     = "my-first-terraform"
}

variable "stage" {
  type        = string
  description = "Deployment stage"
}
