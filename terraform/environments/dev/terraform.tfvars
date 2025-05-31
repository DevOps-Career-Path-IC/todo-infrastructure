environment = "dev"
aws_region     = "ap-southeast-1"
aws_account_id = ""

# VPC Configuration
vpc_cidr           = "10.0.0.0/16"
availability_zones = ["ap-southeast-1a", "ap-southeast-1b"]

# Application Configuration
app_port = 3001

# ECS Task Configuration
app_task_cpu       = 1024
app_task_memory    = 2048
worker_task_cpu    = 1024
worker_task_memory = 2048

# Database Configuration
rds_instance_class        = "db.t3.micro"
rds_allocated_storage     = 20
rds_max_allocated_storage = 100
db_name                   = "todoapp"
db_username               = "postgres"
db_password               = "postgres123"

# Redis Configuration
redis_node_type = "cache.t3.micro"
