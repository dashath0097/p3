terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "~> 1.0"  # Use the latest version
    }
  }
}

provider "spacelift" {
  # Spacelift API credentials (configure via environment variables)
}

# Define a list of AWS account IDs from an environment variable or as a variable


# Define Spacelift space ID
variable "spacelift_space_id" {
  description = "The Spacelift stack to associate AWS accounts with"
  type        = string
}

# Create multiple AWS integrations dynamically
resource "spacelift_aws_integration" "developer_aws" {
  for_each = toset(var.aws_account_ids)  # Iterate over each account ID

  name     = "AWS-${each.value}"
  role_arn = "arn:aws:iam::${each.value}:role/Spacelift"
  space_id = var.spacelift_space_id
}
