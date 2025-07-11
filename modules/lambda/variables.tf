variable "lambda_image_uri" {
}
variable "lambda_function_name" {}
variable "rds_username" {}
variable "rds_password" {}
variable "rds_db_name" {}
variable "bucket_name" {}
variable "env" {}
variable "rds_db_schema" {}
variable "rds_hostname" {}
variable "rds_port" {}
variable "secret" {}
variable "algorithm" {}
variable "url" {}
variable "access_token_expire_minutes" {}
variable "ACCESS_TOKEN_EXPIRE_LOGIN" {}
variable "ACCESS_TOKEN_EXPIRE_MINUTES" {}

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