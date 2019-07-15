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

data "aws_ssm_parameter" "keybase_key" {
  name = "/JENKINS_CHAOS_MASTER/KEYBASE_PAPERKEY"
}
