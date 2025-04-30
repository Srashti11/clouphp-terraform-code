aws_region                         = "us-east-1"
vpc_cidr                           = "10.1.0.0/16"
public_subnet_1_cidr               = "10.1.1.0/24"
public_subnet_2_cidr               = "10.1.2.0/24"
private_subnet_1_cidr              = "10.1.3.0/24"
private_subnet_2_cidr              = "10.1.4.0/24"
availability_zone_1                = "us-east-1a"
availability_zone_2                = "us-east-1b"
instance_type                      = "t3.medium"
key_name                           = "terraform-project"
ubuntu_ami_filter                  = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
ecr_repo_name                      = "cloudphp-staging-repo"  
image_tag_mutability               = "MUTABLE"      
image_scanning                     = true
ecs_cluster_name                   = "cloudphp-staging-ecs-cluster"
ecs_task_execution_role_name       = "ecs-task-execution-role"
ecs_task_family                    = "cloudphp-staging-ecs-task"
ecs_task_cpu                       = "256"
ecs_task_memory                    = "512"
ecs_container_name                 = "cloudphp-staging-container"
ecs_container_image_tag            = "latest"
container_port                     = 80
app_security_group_name            = "app-sg"
ecs_service_name                   = "cloudphp-staging-ecs-service"
ecs_service_desired_count          = 1
assign_public_ip                   = false
lb_name                            = "cloudphp-staging-lb" 
target_group_name                  = "cloudphp-staging-lb-aTG"
target_group_port                  = 80
health_check_path                  = "/"
health_check_interval              = 30
health_check_timeout               = 5
health_check_healthy_threshold     = 2
health_check_unhealthy_threshold   = 2
listener_port                      = 80
alb_security_group_name            = "cloudphp-staging-alb-sg"



# RDS Security Group
rds_sg_name          = "rds-sg"

# DB Subnet Group
db_subnet_group_name = "staging-db-subnet-group"

# DB Instance Configuration
db_identifier             = "cloudphp-staging-rds"
db_engine                 = "mysql"
db_engine_version         = "8.0.40"
db_instance_class         = "db.t3.micro"
db_allocated_storage      = 20
db_name                   = "cloudphpstagingdb"
db_username               = "admin"
db_password               = "Admin$123"  # Use a secure password in production
db_publicly_accessible    = false
db_skip_final_snapshot    = true
db_multi_az               = false
db_storage_encrypted      = true


role_name              = "ec2-ecr-ssm-ecs-full-access-role"
instance_profile_name  = "ec2-full-access-instance-profile"

ecr_policy_arn         = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
ssm_policy_arn         = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
ecs_policy_arn         = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"

log_group_name             = "/ecs/cloudphp-staging"
log_group_retention_in_days = 7


