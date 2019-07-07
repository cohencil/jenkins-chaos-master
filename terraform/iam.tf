data "aws_ssm_parameter" "github_client_sercret" {
  name = "/JENKINS_CHAOS_MASTER/GITHUB_CLIENT_SERCRET"
}

data "aws_ssm_parameter" "ssh_key" {
  name = "/JENKINS_CHAOS_MASTER/PRIMARY_KEY"
}

data "aws_ssm_parameter" "aws_access_key" {
  name = "/JENKINS_CHAOS_MASTER/${var.iam_access_key_id}"
}

data "aws_ssm_parameter" "jenkins_admin_password" {
  name = "/JENKINS_CHAOS_MASTER/JENKINS_ADMIN_PASSWORD"
}

resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = "${terraform.workspace}-chaos-master-iam-instance-profile"
  role = aws_iam_role.chaos_master_role.name
}

data "template_file" "chaos_master_policy" {
  template = file("${path.module}/templates/policy.json.tpl")

  vars = {
    github_client_sercret_arn = data.aws_ssm_parameter.github_client_sercret.arn
    ssh_key_arn               = data.aws_ssm_parameter.ssh_key.arn
    aws_secret_access_key     = data.aws_ssm_parameter.aws_access_key.arn
    jenkins_admin_password    = data.aws_ssm_parameter.jenkins_admin_password.arn
  }
}

resource "aws_iam_policy" "chaos_master_policy" {
  name        = "${terraform.workspace}-chaos-master-policy"
  description = "Additional policies for jenkins-chaos-master"
  policy      = data.template_file.chaos_master_policy.rendered
}

resource "aws_iam_role_policy_attachment" "policy_attach1" {
  role       = aws_iam_role.chaos_master_role.name
  policy_arn = aws_iam_policy.chaos_master_policy.arn
}

resource "aws_iam_role_policy_attachment" "policy_attach2" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role       = aws_iam_role.chaos_master_role.name
}

resource "aws_iam_role_policy_attachment" "policy_attach3" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
  role       = aws_iam_role.chaos_master_role.name
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
