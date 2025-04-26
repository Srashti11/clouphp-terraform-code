resource "aws_security_group" "cloudphp_staging_rds_SG" {
  name        = var.rds_sg_name
  vpc_id      = aws_vpc.cloudphp_staging_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "cloudphp_staging_db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = [aws_subnet.private_sub_1.id, aws_subnet.private_sub_2.id]
}

resource "aws_db_instance" "cloudphp_staging_rds" {
  identifier             = var.db_identifier
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_allocated_storage
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  publicly_accessible    = var.db_publicly_accessible
  skip_final_snapshot    = var.db_skip_final_snapshot
  vpc_security_group_ids = [aws_security_group.cloudphp_staging_rds_SG.id]
  db_subnet_group_name   = aws_db_subnet_group.cloudphp_staging_db_subnet_group.name
  multi_az               = var.db_multi_az
  storage_encrypted      = var.db_storage_encrypted

 
}
