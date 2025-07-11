resource "aws_ecr_repository" "lambda_ecr_repo" {
  name                 = "${var.lambda_function_name}_repo"
  image_tag_mutability = "MUTABLE"

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_ecr_lifecycle_policy" "lambda_ecr_lifecycle" {
  repository = aws_ecr_repository.lambda_ecr_repo.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 2 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 2
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}