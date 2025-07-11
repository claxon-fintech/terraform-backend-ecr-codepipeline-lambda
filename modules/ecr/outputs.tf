output "image_uri" {
  description = "The URI of the ECR image with the latest tag"
  value       = "${aws_ecr_repository.lambda_ecr_repo.repository_url}:latest"
}
