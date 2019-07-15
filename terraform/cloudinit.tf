data "template_cloudinit_config" "cloundinit_config" {
  gzip          = false
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/cloudinit/cloud_config", {
      instance_name = terraform.workspace
      domain_name   = var.domain
      region        = var.region
      user          = var.os_user
    })
  }

  part {
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/cloudinit/docker.sh", {
      user    = var.os_user
      version = "1.23.2"
    })
  }

  part {
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/cloudinit/git.sh", {
      user = var.os_user
    })
  }

  part {
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/cloudinit/aws.sh", {
      user   = var.os_user
      region = var.region
    })
  }

  part {
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/cloudinit/terraform.sh", {
      version = "0.12.3"
    })
  }

  part {
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/cloudinit/certbot.sh", {
      hostmaster_email = "webmaster@tikal.io"
      instance_name    = terraform.workspace
      domain_name      = var.domain
    })
  }

  part {
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/cloudinit/keybase.sh", {
      user         = var.os_user
      paperkey     = data.aws_ssm_parameter.keybase_key.value
      keybase_user = "shelleg"
    })
  }

  part {
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/cloudinit/run.sh", {
      aws_access_key_id     = var.iam_access_key_id
      aws_secret_access_key = data.aws_ssm_parameter.aws_access_key.value
      user                  = var.os_user
    })
  }

}

data "aws_ssm_parameter" "keybase_key" {
  name = "/JENKINS_CHAOS_MASTER/KEYBASE_PAPERKEY"

}
