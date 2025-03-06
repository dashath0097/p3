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
variable "aws_account_ids" {
  description = "List of AWS Account IDs for integration"
  type        = list(string)
  default     = []  # Keep it empty initially
}



# Create multiple AWS integrations dynamically
resource "spacelift_aws_integration" "developer_aws" {
  for_each = toset(var.aws_account_ids)  # Iterate over each account ID

  name     = "AWS-${each.value}"
  role_arn = "arn:aws:iam::${each.value}:role/Spacelift"
  space_id = var.spacelift_space_id
}
