#  -------------------------------------- CodePipeline -----------------------------------------------------------
resource "aws_codepipeline" "lambda_pipeline" {
  name     = "${var.lambda_function_name}-pipeline"
  role_arn = aws_iam_role.lambda_pipeline_role.arn
  pipeline_type = "V2"
  

  artifact_store {
    location = aws_s3_bucket.pipeline_artifacts.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        FullRepositoryId = var.FullRepositoryId
        BranchName       = var.github_branch
        ConnectionArn    = var.github_oauth_token

      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = var.codebuild_project_name


        EnvironmentVariables = jsonencode([
          {
            name  = "AWS_ACCOUNT_ID"
            value = data.aws_caller_identity.current.account_id
            type  = "PLAINTEXT"
          },
          {
            name  = "AWS_DEFAULT_REGION"
            value = var.aws_region
            type  = "PLAINTEXT"
          },
          {
            name  = "IMAGE_REPO_NAME"
            value = "${var.lambda_function_name}_repo"
            type  = "PLAINTEXT"
          },
          {
            name  = "IMAGE_TAG"
            value = "latest"
            type  = "PLAINTEXT"
          },
          {
            name  = "FUNCTION_NAME"
            value = var.lambda_function_name
            type  = "PLAINTEXT"
          }
        ])
      }
    }
  }
}

# <----------------------- S3 Bucket for Pipeline Artifacts ------------------------>
resource "aws_s3_bucket" "pipeline_artifacts" {
  bucket        = "${var.lambda_function_name}-${var.aws_region}-pipeline-artifacts"
  force_destroy = true
}



# ------------------------------------------------------------  CodePipeline IAM Role ----------------------------------
resource "aws_iam_role" "lambda_pipeline_role" {
  name = "${var.lambda_function_name}-pipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "codepipeline.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  
}

# put artifacts policy

resource "aws_iam_role_policy" "pipeline_artifacts_s3_write" {
  name = "${var.lambda_function_name}_AllowPutToPipelineArtifactsBucket"
  role = aws_iam_role.lambda_pipeline_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:GetBucketVersioning"
        ],
        Resource = [
          "arn:aws:s3:::*",

        ]
      }
    ]
  })
}

# <---------------------   CodeStarPolicy --------------------------------------- >
resource "aws_iam_role_policy" "allow_codestar_connection" {
  name = "${var.lambda_function_name}_AllowUseOfCodeStarConnection"
  role = aws_iam_role.lambda_pipeline_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["codestar-connections:UseConnection"],
        Resource = "arn:aws:codeconnections:eu-west-1:165194454526:connection/6595994d-ebbd-4737-83e5-2d8876fb8d0e"
      },


    ]
  })
}


# <---------------------- codepipeline policy to access codebuild ------------------------->

resource "aws_iam_role_policy_attachment" "pipeline_codebuild_dev_access" {
  role       = aws_iam_role.lambda_pipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}

# <-------------- Pipeline policy Attach ---------------------------------->
resource "aws_iam_role_policy_attachment" "lambda_pipeline_policy_attach" {
  role       = aws_iam_role.lambda_pipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
  
}

