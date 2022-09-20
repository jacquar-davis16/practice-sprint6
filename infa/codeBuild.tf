resource "aws_s3_bucket" "codeBuildBucket" {
  bucket = "dd-bucket-testbuild-091622-2"

  force_destroy = true

}

resource "aws_s3_bucket_acl" "cbBucketACL" {
  bucket = aws_s3_bucket.codeBuildBucket.id
  acl    = "private"
}

resource "aws_iam_role" "cbRole" {
  name = "codeBuildServiceRole"

  assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Effect": "Allow",
            "Principal": {
                "Service": "codebuild.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
            }
        ]
    }
    EOF
}

resource "aws_cloudwatch_log_group" "cloudWatchGroup" {

  name              = "DD-CB-CodeBuild-LogGroup"
  retention_in_days = 0

}

resource "aws_iam_role_policy" "cbPolicy" {

  role = aws_iam_role.cbRole.name
  name = "policyForCodeBuild"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "${aws_cloudwatch_log_group.cloudWatchGroup.arn}",
                "${aws_cloudwatch_log_group.cloudWatchGroup.arn}:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "${aws_s3_bucket.codeBuildBucket.arn}",
                "${aws_s3_bucket.codeBuildBucket.arn}/*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        }
    ]
}
POLICY

}


resource "aws_codebuild_project" "codeBuildProject" {
  name         = "DDs-CodeBuild-Project"
  service_role = aws_iam_role.cbRole.arn

  artifacts {
    type      = "S3"
    packaging = "ZIP"
    location  = aws_s3_bucket.codeBuildBucket.bucket
    name      = "output-here"
  }

  source {
    buildspec = "buildspec_CodeBuild.yml"

    type            = "GITHUB"
    location        = "https://github.com/jacquar-davis16/practice-sprint6.git"
    git_clone_depth = 1
  }

  environment {

    type         = "LINUX_CONTAINER"
    image        = "aws/codebuild/standard:6.0"
    compute_type = "BUILD_GENERAL1_MEDIUM"


  }

  logs_config {
    cloudwatch_logs {
      group_name = aws_cloudwatch_log_group.cloudWatchGroup.name
    }
  }

  source_version = "dev"


}


/*resource "aws_codebuild_webhook" "webHook" {

  project_name = aws_codebuild_project.codeBuildProject.name
  build_type   = "BUILD"
  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PULL_REQUEST_CREATED,PULL_REQUEST_UPDATED,PULL_REQUEST_REOPENED"
    }

    filter {
      type    = "HEAD_REF"
      pattern = "^refs/heads/dev$"
    }

    filter {
      type    = "BASE_REF"
      pattern = "^refs/heads/main$"

    }
  }

}

*/
