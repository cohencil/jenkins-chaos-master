data "aws_caller_identity" "current" {}

resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = "${terraform.workspace}-chaos-master-iam-instance-profile"
  role = aws_iam_role.chaos_master_role.name
}

resource "aws_iam_role_policy_attachment" "policy_attach1" {
  role       = aws_iam_role.chaos_master_role.name
  policy_arn = aws_iam_policy.chaos_master_policy.arn
}

resource "aws_iam_role_policy_attachment" "policy_attach2" {
  role       = aws_iam_role.chaos_master_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "policy_attach3" {
  role       = aws_iam_role.chaos_master_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
}

resource "aws_iam_role" "chaos_master_role" {
  name        = "${terraform.workspace}-chaos-master-role"
  description = "Allows EC2 instances to call AWS services on your behalf."
  tags        = local.common_tags

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "chaos_master_policy" {
  name        = "${terraform.workspace}-chaos-master-policy"
  description = "Additional policies for jenkins-chaos-master"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameterHistory",
                "ssm:GetParametersByPath",
                "ssm:GetParameters",
                "ssm:GetParameter"
            ],
            "Resource": [
                "${data.aws_ssm_parameter.ssh_key.arn}",
                "${data.aws_ssm_parameter.github_client_sercret.arn}",
                "${data.aws_ssm_parameter.aws_access_key.arn}",
                "${data.aws_ssm_parameter.jenkins_admin_password.arn}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:GetRole",
                "iam:GetPolicyVersion",
                "iam:GetInstanceProfile",
                "iam:GetPolicy",
                "iam:ListAttachedRolePolicies"
            ],
            "Resource": [
                "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/${terraform.workspace}-chaos-master-policy",
                "${aws_iam_instance_profile.iam_instance_profile.arn}",
                "${aws_iam_role.chaos_master_role.arn}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::*"
        }
    ]
}
EOF
}
