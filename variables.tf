variable "instance_name" {
  type        = string
  description = "The name of the instance"
  default     = "paa"
}

variable "environment" {
  type        = string
  description = "The environment (dev, staging, prod)"
  default     = "dev"
}

variable "instance_type" {
  type        = string
  description = "The size of the web server instance"
  default     = "t2.micro"
}

variable "project_name" {
  type        = string
  description = "The name of the project"
  default     = "default-project"
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources"
  default     = "eu-west-1"
}

variable "lambda_function_name" {
  type        = string
  description = "Name of the Lambda function"
}



variable "lambda_image_uri" {
  type        = string
  description = "URI of the Lambda container image"
}

variable "rds_username" {
  type        = string
  description = "RDS database username"

}

variable "rds_password" {
  type        = string
  description = "RDS database password"

}

variable "rds_db_name" {
  type        = string
  description = "RDS database name"
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name"
}

variable "env" {
  type        = string
  description = "Application environment"
}

variable "rds_db_schema" {
  type        = string
  description = "RDS database schema"
}

variable "rds_hostname" {
  type        = string
  description = "RDS hostname"
}

variable "rds_port" {
  type        = string
  description = "RDS port"
}

variable "secret" {
  type        = string
  description = "Application secret key"

}

variable "algorithm" {
  type        = string
  description = "Encryption algorithm"
}
variable "url" {
  type        = string
  description = "Application URL"
}


variable "github_owner" {
  type        = string
  description = "GitHub organization or user"
}

variable "FullRepositoryId" {
  type        = string
  description = "GitHub FullRepositoryId"
}

variable "github_branch" {
  type        = string
  default     = "main"
  description = "GitHub branch for the source stage"
}

variable "github_oauth_token" {
  type        = string
  sensitive   = true
  description = "GitHub OAuth token with repo access"
}
variable "access_token_expire_minutes" {
  type        = string
  sensitive   = true
  description = "System token access tokenn expiry time"
}
variable "ACCESS_TOKEN_EXPIRE_LOGIN" {
  type        = string
  sensitive   = true
  description = "System token access tokenn expiry time"
}
variable "ACCESS_TOKEN_EXPIRE_MINUTES" {
  type        = string
  sensitive   = true
  description = "System token access tokenn expiry time"
}

variable "SECRET_KEY_GMM" {
  description = "Secret key for GMM module"
  type        = string
  default     = "none"
}

variable "SECRET_KEY_PAA" {
  description = "Secret key for PAA module"
  type        = string
  default     = "none"
}

variable "SECRET_KEY_VFA" {
  description = "Secret key for VFA module"
  type        = string
  default     = "none"
}

variable "BUCKET_NAME" {
  description = "S3 Bucket Name"
  type        = string
  default     = "none"
}

variable "API_KEY" {
  description = "API Key"
  type        = string
  default     = "none"
}

variable "API_KEY_NAME" {
  description = "API Key Name"
  type        = string
  default     = "none"
}

variable "AUTH_SERVICE_URL" {
  description = "Authentication Service URL"
  type        = string
  default     = "none"
}
