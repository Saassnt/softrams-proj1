resource "aws_codepipeline" "pipeline" {
  name     = "${var.cluster_name}-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.source.bucket
    type     = "S3"

  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source"]

      configuration = {
        OAuthToken  = var.github_token
        Owner  = var.git_repository_owner
        Repo   = var.git_repository_name
        Branch = var.git_repository_branch
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
      version          = "1"
      input_artifacts  = ["source"]
      output_artifacts = ["imagedefinitions"]

      configuration = {
        ProjectName = "${var.cluster_name}-codebuild"
      }
    }
  }

  stage {
    name = "Production"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["imagedefinitions"]
      version         = "1"

      configuration = {
        ClusterName = var.cluster_name
        ServiceName = var.app_service_name
        FileName    = "imagedefinitions.json"
      }
    }
  }
  lifecycle {
    ignore_changes =  [stage[1].action[1].configuration]
  }
}

# A shared secret between GitHub and AWS that allows AWS
# CodePipeline to authenticate the request came from GitHub.
# Would probably be better to pull this from the environment
# or something like SSM Parameter Store.

locals {
  webhook_secret = "super-secret"
}

resource "aws_codepipeline_webhook" "pipeline" {
  name            = "test-webhook-github-pipeline"
  authentication  = "GITHUB_HMAC"
  target_action   = "Source"
  target_pipeline = aws_codepipeline.pipeline.name

  authentication_configuration {
    secret_token = local.webhook_secret
  }

  filter {
    json_path    = "$.ref"
    match_equals = "refs/heads/{Branch}"
  }
}

# Wire the CodePipeline webhook into a GitHub repository.

resource "github_repository_webhook" "pipeline" {
  repository = var.git_repository_name

  #name = "web"

  configuration {
    url          = aws_codepipeline_webhook.pipeline.url
    content_type = "json"
    insecure_ssl = true
    secret       = local.webhook_secret
  }

  events = ["push"]
}
