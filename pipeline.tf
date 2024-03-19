resource "aws_codepipeline" "pipeline" {
  name     = "my-pipeline"
  role_arn = aws_iam_role.pipeline.arn

  artifact_store {
    location = aws_s3_bucket.artifact_store.bucket
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
        ConnectionArn    = var.github_connection
        FullRepositoryId = var.github_repository
        BranchName       = var.github_branch
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
        ProjectName = aws_codebuild_project.build.name
      }
    }
  }
}

resource "aws_iam_role" "pipeline" {
  name = "pipeline"

  assume_role_policy = jsonencode({
    "Version"   : "2012-10-17",
    "Statement" : [{
      "Action"    : "sts:AssumeRole",
      "Principal" : {
        "Service" : "codepipeline.amazonaws.com"
      },
      "Effect"    : "Allow",
      "Sid"       : ""
    }]
  })
}

resource "aws_iam_policy" "pipeline_policy" {
  name   = "pipeline_policy"
  policy = jsonencode({
    "Version"   : "2012-10-17",
    "Statement" : [{
      "Effect"   : "Allow",
      "Action"   : [
        "codepipeline:StartPipelineExecution",
        "codepipeline:StopPipelineExecution",
        "codepipeline:GetPipeline",
        "codepipeline:GetPipelineExecution",
        "codepipeline:GetPipelineState"
      ],
      "Resource" : "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "pipeline_policy_attachment" {
  policy_arn = aws_iam_policy.pipeline_policy.arn
  role       = aws_iam_role.pipeline.name
}

resource "aws_s3_bucket" "artifact_store" {
  bucket = var.s3_artifact_bucket_name
}

resource "aws_codebuild_project" "build" {
  name          = var.build_project_name
  description   = "My CodeBuild project"
  service_role  = aws_iam_role.codebuild.arn
  build_timeout = 5

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }
}

resource "aws_iam_role" "codebuild" {
  name = "codebuild"

  assume_role_policy = jsonencode({
    "Version"   : "2012-10-17",
    "Statement" : [{
      "Action"    : "sts:AssumeRole",
      "Principal" : {
        "Service" : "codebuild.amazonaws.com"
      },
      "Effect"    : "Allow",
      "Sid"       : ""
    }]
  })
}

resource "aws_iam_role_policy" "codebuild" {
  role = aws_iam_role.codebuild.id

  policy = jsonencode({
    "Version"   : "2012-10-17",
    "Statement" : [{
      "Effect"   : "Allow",
      "Action"   : [
        "codecommit:GitPull",
        "s3:PutObject",
        "s3:GetObject",
        "s3:ListBucket",
        "lambda:UpdateFunctionCode"
      ],
      "Resource" : "*"
    }]
  })
}
