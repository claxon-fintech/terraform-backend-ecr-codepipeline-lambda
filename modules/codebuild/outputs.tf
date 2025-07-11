output "codebuild_project_name" {
  value       = aws_codebuild_project.lambda_build_project.name
  description = "Name of the CodeBuild project for Lambda build"
}
