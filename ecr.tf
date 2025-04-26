resource "aws_ecr_repository" "cloudphp_staging_ecr_repo" {
  name                 = var.ecr_repo_name
  image_tag_mutability = var.image_tag_mutability  
  image_scanning_configuration {
    scan_on_push = var.image_scanning
  }
}