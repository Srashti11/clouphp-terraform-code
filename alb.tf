resource "aws_lb" "cloudphp_staging_lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.cloudphp_staging_lb_SG.id]
  subnets            = [aws_subnet.pub_sub_1.id, aws_subnet.private_sub_2.id]
  enable_deletion_protection = false

  tags = {
    Name = "MyAppLoadBalancer"
  }
}

resource "aws_lb_target_group" "cloudphp_staging_lb_target_group" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.cloudphp_staging_vpc.id

  health_check {
    path                = var.health_check_path
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }
}

resource "aws_lb_listener" "cloudphp_staging_lb_listener" {
  load_balancer_arn = aws_lb.cloudphp_staging_lb.arn
  port              = var.listener_port
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cloudphp_staging_lb_target_group.arn
  }
}

resource "aws_security_group" "cloudphp_staging_lb_SG" {
  name        = var.alb_security_group_name
  description = "Allow HTTP traffic"
  vpc_id      = aws_vpc.cloudphp_staging_vpc.id

  ingress {
    from_port   = 80  # Hardcoded
    to_port     = 80  # Hardcoded
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


