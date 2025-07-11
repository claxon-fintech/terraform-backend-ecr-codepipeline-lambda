variable "lambda_function_name" {
  
}

variable "aws_region" {

}

variable "FullRepositoryId" {

}

variable "github_branch" {

}

variable "github_oauth_token" {
}

variable "codebuild_project_name" {
  type        = string
  description = "The name of the CodeBuild project to use in CodePipeline"
}
