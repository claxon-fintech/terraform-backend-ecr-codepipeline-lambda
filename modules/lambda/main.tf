# Lambda Function Using ECR Image
resource "aws_lambda_function" "lambda_function" {
  function_name = var.lambda_function_name
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.lambda_ecr_repo.repository_url}:latest"
  role          = aws_iam_role.lambda_exec_role.arn
  memory_size   = 10240
  timeout       = 300


  environment {
    variables = {
      RDS_USERNAME                 = var.rds_username
      RDS_PASSWORD                 = var.rds_password
      RDS_DB_NAME                  = var.rds_db_name
      BUCKET_NAME                  = var.bucket_name
      ENV                          = var.env
      RDS_DB_SCHEMA                = var.rds_db_schema
      RDS_HOSTNAME                 = var.rds_hostname
      RDS_PORT                     = var.rds_port
      secret                       = var.secret
      secret_key                   = var.secret
      algorithm                    = var.algorithm
      URL                          = var.url
      frontend_url                 = var.url
      access_token_expire_minutes = var.access_token_expire_minutes
      ACCESS_TOKEN_EXPIRE_MINUTES = var.ACCESS_TOKEN_EXPIRE_MINUTES
      ACCESS_TOKEN_EXPIRE_LOGIN   = var.ACCESS_TOKEN_EXPIRE_LOGIN

      SECRET_KEY_GMM               = var.SECRET_KEY_GMM
      SECRET_KEY_PAA               = var.SECRET_KEY_PAA
      SECRET_KEY_VFA               = var.SECRET_KEY_VFA
      API_KEY                      = var.API_KEY
      API_KEY_NAME                 = var.API_KEY_NAME
      AUTH_SERVICE_URL             = var.AUTH_SERVICE_URL
    }
  }


}

# Lambda Function UR
resource "aws_lambda_function_url" "lambda_function_url" {
  function_name      = aws_lambda_function.lambda_function.function_name
  authorization_type = "NONE"
}