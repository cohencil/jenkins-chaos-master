resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = "jenkins-chaos-master-iam-instance-profile"
  role = aws_iam_role.jenkins_chaos_master_role.name
}

resource "aws_iam_role" "jenkins_chaos_master_role" {
  name        = "jenkins-chaos-master-role"
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

resource "aws_iam_policy" "jenkins_chaos_master_policy" {
  name = "jenkins-chaos-master-policy"
  description = "Additional policies for jenkins-chaos-master"
  policy = <<EOF
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
            "Resource": "arn:aws:ssm:eu-central-1:329054710135:parameter/JENKINS_CHAOS_MASTER/PRIMARY_KEY"
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
                "arn:aws:iam::329054710135:policy/jenkins-chaos-master-policy",
                "arn:aws:iam::*:instance-profile/*",
                "arn:aws:iam::329054710135:role/jenkins-chaos-master-role"
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

resource "aws_iam_role_policy_attachment" "policy_attach1" {
  role       = aws_iam_role.jenkins_chaos_master_role.name
  policy_arn = aws_iam_policy.jenkins_chaos_master_policy.arn
}

resource "aws_iam_role_policy_attachment" "policy_attach2" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role       = aws_iam_role.jenkins_chaos_master_role.name
}

resource "aws_iam_role_policy_attachment" "policy_attach3" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
  role       = aws_iam_role.jenkins_chaos_master_role.name
}
