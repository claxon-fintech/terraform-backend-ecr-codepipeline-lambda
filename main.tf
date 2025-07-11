module "ecr" {
  source = "./modules/ecr"
  lambda_function_name = var.lambda_function_name
}

module "codepipeline" {
  source = "./modules/codepipeline"
  lambda_function_name=var.lambda_function_name
  aws_region = var.aws_region
  github_oauth_token = var.github_oauth_token
  github_branch = var.github_branch
  FullRepositoryId = var.FullRepositoryId
  codebuild_project_name = module.codebuild.codebuild_project_name

}

module "codebuild" {
    source = "./modules/codebuild"
    lambda_function_name=var.lambda_function_name
  
}

module "lambda" {
  source = "./modules/lambda"
  lambda_function_name=var.lambda_function_name
  image_uri = module.ecr.image_uri
  env = var.env
  rds_db_schema = var.rds_db_schema
  rds_db_name = var.rds_db_name
  bucket_name = var.bucket_name
  access_token_expire_minutes = var.access_token_expire_minutes
  algorithm = var.algorithm
  rds_username = var.rds_username
  rds_password = var.rds_password
  rds_hostname = var.rds_hostname
  rds_port = var.rds_port
  url = var.url
  secret = var.secret
  ACCESS_TOKEN_EXPIRE_LOGIN = var.ACCESS_TOKEN_EXPIRE_LOGIN
  ACCESS_TOKEN_EXPIRE_MINUTES = var.ACCESS_TOKEN_EXPIRE_MINUTES

}