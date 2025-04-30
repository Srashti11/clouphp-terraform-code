variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = ""  # You can set a default region or leave it out to force it to be specified in tfvars
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for the first public subnet"
  type        = string
  default     = ""
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for the second public subnet"
  type        = string
  default     = ""
}

variable "private_subnet_1_cidr" {
  description = "CIDR block for the first private subnet"
  type        = string
  default     = ""
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for the second private subnet"
  type        = string
  default     = ""
}

variable "availability_zone_1" {
  description = "Availability zone for the first subnet"
  type        = string
  default     = ""
}

variable "availability_zone_2" {
  description = "Availability zone for the second subnet"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "Instance type for Jenkins server"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "Key name for the EC2 instance"
  type        = string
  default     = ""
}

variable "ubuntu_ami_filter" {
  description = "AMI filter for the latest Ubuntu image"
  type        = string
  default     = ""
}

variable "ecr_repo_name" {
  description = "The name of the ECR repository"
  type        = string
  default     = ""
}

variable "image_tag_mutability" {
  description = "The mutability of the image tags in the ECR repository"
  type        = string
  default     = ""  # Can be "MUTABLE" or "IMMUTABLE"
}

variable "image_scanning" {
  description = "Enable image scanning on push"
  type        = bool
  default     = true
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = ""
}

variable "ecs_task_execution_role_name" {
  description = "The name of the ECS task execution role"
  type        = string
  default     = ""
}

variable "ecs_task_family" {
  description = "The family name of the ECS task definition"
  type        = string
  default     = ""
}

variable "ecs_task_cpu" {
  description = "The amount of CPU for the ECS task"
  type        = string
  default     = ""
}

variable "ecs_task_memory" {
  description = "The amount of memory for the ECS task"
  type        = string
  default     = ""
}

variable "ecs_container_name" {
  description = "The name of the ECS container"
  type        = string
  default     = ""
}

variable "ecs_container_image_tag" {
  description = "The image tag for the container"
  type        = string
  default     = ""
}

variable "container_port" {
  description = "The port on which the container will listen"
  type        = number
  
}

variable "app_security_group_name" {
  description = "The name of the security group for the app"
  type        = string
  default     = ""
}


variable "ecs_service_name" {
  description = "The name of the ECS service"
  type        = string
  default     = ""
}

variable "ecs_service_desired_count" {
  description = "The desired number of tasks for the ECS service"
  type        = number
 
}

variable "assign_public_ip" {
  description = "Whether the ECS task should have a public IP"
  type        = bool
  default     = false
}

variable "lb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
  default     = ""
}


variable "target_group_name" {
  description = "The name of the target group"
  type        = string
  default     = ""
}

variable "target_group_port" {
  description = "The port of the target group"
  type        = number
  
}

variable "health_check_path" {
  description = "The path for the health check"
  type        = string
  default     = ""
}

variable "health_check_interval" {
  description = "The interval between health checks"
  type        = number
  
}

variable "health_check_timeout" {
  description = "The timeout for health checks"
  type        = number
  
}

variable "health_check_healthy_threshold" {
  description = "The number of successful health checks before marking a target as healthy"
  type        = number
}

variable "health_check_unhealthy_threshold" {
  description = "The number of failed health checks before marking a target as unhealthy"
  type        = number
  
}

variable "listener_port" {
  description = "The port the listener will listen on"
  type        = number
  
}

variable "alb_security_group_name" {
  description = "The name of the security group for the load balancer"
  type        = string
  default     = ""
}


#################

variable "rds_sg_name" {
  description = "Name of the RDS security group"
  type        = string
  default     = ""
}

variable "db_subnet_group_name" {
  description = "Name of the DB subnet group"
  type        = string
  default     = ""
}


variable "db_identifier" {
  description = "Identifier for the DB instance"
  type        = string
  default     = ""
}

variable "db_engine" {
  description = "Database engine"
  type        = string
  default     = ""
}


variable "db_engine_version" {
  description = "Version of the database engine"
  type        = string
  default     = ""
}

variable "db_instance_class" {
  description = "The instance class for the DB"
  type        = string
  default     = ""
}

variable "db_allocated_storage" {
  description = "Storage allocated in GB"
  type        = number
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "stagingdb"
}

variable "db_username" {
  description = "Master username for RDS"
  type        = string
  default     = ""
}

variable "db_password" {
  description = "Master password for RDS"
  type        = string
  sensitive   = true
}

variable "db_publicly_accessible" {
  description = "Whether the DB instance is publicly accessible"
  type        = bool
  
}

variable "db_skip_final_snapshot" {
  description = "Skip final snapshot on deletion"
  type        = bool
  
}

variable "db_multi_az" {
  description = "Whether to enable Multi-AZ deployment"
  type        = bool
  
}

variable "db_storage_encrypted" {
  description = "Whether storage is encrypted"
  type        = bool
  
}

variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "instance_profile_name" {
  description = "The name of the IAM instance profile"
  type        = string
}

variable "ecr_policy_arn" {
  description = "The ARN of the ECR full access policy"
  type        = string
}

variable "ssm_policy_arn" {
  description = "The ARN of the SSM full access policy"
  type        = string
}

variable "ecs_policy_arn" {
  description = "The ARN of the ECS full access policy"
  type        = string
}

variable "log_group_name" {
  description = "Name of the CloudWatch Log Group for ECS task logs"
  type        = string
}

# Log Group Retention Days
variable "log_group_retention_in_days" {
  description = "Retention time in days for log events"
  type        = number
  default     = 7
}






