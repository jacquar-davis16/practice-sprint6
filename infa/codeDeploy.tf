resource "aws_iam_role" "codeDeployRole" {
  name = "codeDeployRole"

  assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Effect": "Allow",
            "Principal": {
                "Service": "codedeploy.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
            }
        ]
    }
    EOF
}

resource "aws_iam_policy_attachment" "codeDeployPolicyAttachment" {

  name       = "codeDeploy_attachment"
  roles      = [aws_iam_role.codeDeployRole.name]
  policy_arn = data.aws_iam_policy.managedCodeDeployPolicy.arn

}

data "aws_iam_policy" "managedCodeDeployPolicy" {
  name = "AWSCodeDeployRole"
}