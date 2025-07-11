
# <--------------------------------- Code Build Project ---------------------------------->
resource "aws_codebuild_project" "lambda_build_project" {
  name         = "${var.lambda_function_name}-build"
  service_role = aws_iam_role.lambda_build_role.arn

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:7.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
  }
}


# IAM Roles (for CodeBuild & CodePipeline)
resource "aws_iam_role" "lambda_build_role" {
  name = "${var.lambda_function_name}-build-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "codebuild.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_build_policy_attach" {
  role       = aws_iam_role.lambda_build_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}

# UPDATE THE LAMBDA IMAGE POLICY

resource "aws_iam_role_policy" "lambda_update_code_policy" {
  role = aws_iam_role.lambda_build_role.name
  name        = "LambdaUpdateFunctionCodePolicy"

  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "lambda:UpdateFunctionCode"
        ],
        Resource = "*"
      }
    ]
  })
}

# cloudwatch logs for codebuild


resource "aws_iam_role_policy" "codebuild_logs_policy" {
  name = "CodeBuildCloudWatchLogsPolicy"
  role = aws_iam_role.lambda_build_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject"

        ],
        "Resource" : "arn:aws:s3:::*"
      }

      ,
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:DescribeImages",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:GetAuthorizationToken",
          "ecr:GetDownloadUrlForLayer",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:ListTagsForResource"
        ],
        Resource = "*"
      },
    ]
  })
}
