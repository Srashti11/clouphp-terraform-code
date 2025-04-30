resource "aws_ecs_cluster" "cloudphp_staging_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_iam_role" "ecs_task_exec_role" {
  name               = var.ecs_task_execution_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

resource "aws_cloudwatch_log_group" "cloudphp_log_group" {
  name              = "ecs-log-group"
  retention_in_days = 7
}

resource "aws_iam_role_policy_attachment" "ecs_task_exec_attach" {
  role       = aws_iam_role.ecs_task_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "cloudphp_staging_task" {
  family                   = var.ecs_task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_task_cpu
  memory                   = var.ecs_task_memory
  execution_role_arn       = aws_iam_role.ecs_task_exec_role.arn
  task_role_arn            = aws_iam_role.ecs_task_exec_role.arn
  container_definitions = jsonencode([
    {
      name      = var.ecs_container_name
      image     = "${aws_ecr_repository.cloudphp_staging_ecr_repo.repository_url}:${var.ecs_container_image_tag}"
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ],

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.cloudphp_log_group.name
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = var.ecs_container_name
        }
      }
    }
  ])
}

resource "aws_security_group" "cloudphp_staging_ecs_service_SG" {
  name        = var.app_security_group_name
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.cloudphp_staging_vpc.id

   ingress {
    description      = "Allow HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

   ingress {
    description      = "Allow HTTP"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

   egress {
    description      = "Allow all outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}


resource "aws_ecs_service" "cloudphp_staging_ecs_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.cloudphp_staging_cluster.id
  task_definition = aws_ecs_task_definition.cloudphp_staging_task.arn
  desired_count   = var.ecs_service_desired_count
  launch_type     = "FARGATE"
  platform_version = "LATEST"
  network_configuration {
    subnets          = [aws_subnet.private_sub_1.id, aws_subnet.private_sub_2.id]
    security_groups = [aws_security_group.cloudphp_staging_ecs_service_SG.id]
    assign_public_ip = var.assign_public_ip
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.cloudphp_staging_lb_target_group.arn
    container_name   = var.ecs_container_name
    container_port   = var.container_port
  }
  depends_on = [aws_lb_listener.cloudphp_staging_lb_listener]
}



