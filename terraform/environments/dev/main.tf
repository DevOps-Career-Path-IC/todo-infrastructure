locals {
  name_prefix = "todo-app"
  tags = {
    Name        = local.name_prefix
    Project     = local.name_prefix
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

# Create IAM roles




# aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 533267232987.dkr.ecr.ap-southeast-1.amazonaws.com
# docker build --platform linux/amd64 -t 533267232987.dkr.ecr.ap-southeast-1.amazonaws.com/todo-app-dev:api-latest .
# docker tag 533267232987.dkr.ecr.ap-southeast-1.amazonaws.com/todo-app-dev:api-latest
# docker push 533267232987.dkr.ecr.ap-southeast-1.amazonaws.com/todo-app-dev:api-latest

# docker build --platform linux/amd64 -t 533267232987.dkr.ecr.ap-southeast-1.amazonaws.com/todo-app-dev:worker-latest .
# docker tag 533267232987.dkr.ecr.ap-southeast-1.amazonaws.com/todo-app-dev:worker-latest
# docker push 533267232987.dkr.ecr.ap-southeast-1.amazonaws.com/todo-app-dev:worker-latest
