provider "spacelift" {
  # Spacelift API credentials (configure via environment variables)
}

# Define a list of AWS account IDs as a Terraform variable or environment variable
variable "aws_account_ids" {
  description = "List of AWS Account IDs for integration"
  type        = list(string)
  default     = []  # Keep it empty initially
}

resource "spacelift_aws_integration" "developer_aws" {
  for_each = toset(var.aws_account_ids)  # Create an integration for each account ID

  name     = "AWS-${each.value}"
  role_arn = "arn:aws:iam::${each.value}:role/Spacelift"
  space_id = var.spacelift_space_id
}
