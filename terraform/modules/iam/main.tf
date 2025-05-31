terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  tags = {
    Name        = "${var.name_prefix}-iam"
    Environment = var.environment
    Project     = var.name_prefix
    ManagedBy   = "terraform"
  }
}

# Create IAM roles
resource "aws_iam_role" "roles" {
  for_each = var.roles

  name               = "${var.name_prefix}-${var.environment}-${each.value.name}"
  assume_role_policy = each.value.assume_role_policy

  tags = merge(local.tags, {
    Role = each.value.name
  })
}

# Create IAM policies
resource "aws_iam_policy" "policies" {
  for_each = {
    for policy in flatten([
      for role_key, role in var.roles : [
        for policy_key, policy in role.policies : {
          role_key   = role_key
          policy_key = policy_key
          name       = policy.name
          description = policy.description
          policy     = policy.policy
        }
      ]
    ]) : "${policy.role_key}-${policy.policy_key}" => policy
  }

  name        = "${var.name_prefix}-${var.environment}-${each.value.name}"
  description = each.value.description
  policy      = each.value.policy

  tags = merge(local.tags, {
    Role = split("-", each.key)[0]
  })
}

# Attach policies to roles
resource "aws_iam_role_policy_attachment" "policy_attachments" {
  for_each = {
    for policy in flatten([
      for role_key, role in var.roles : [
        for policy_key, policy in role.policies : {
          role_key   = role_key
          policy_key = policy_key
        }
      ]
    ]) : "${policy.role_key}-${policy.policy_key}" => policy
  }

  role       = aws_iam_role.roles[each.value.role_key].name
  policy_arn = aws_iam_policy.policies["${each.value.role_key}-${each.value.policy_key}"].arn
}

# Create instance profiles for roles that need them
resource "aws_iam_instance_profile" "profiles" {
  for_each = {
    for role_key, role in var.roles : role_key => role
    if can(regex("ec2", role.name))
  }

  name = "${var.name_prefix}-${var.environment}-${each.value.name}-profile"
  role = aws_iam_role.roles[each.key].name

  tags = merge(local.tags, {
    Role = each.value.name
  })
}
