data "template_cloudinit_config" "cloundinit_config" {
  gzip          = false
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = data.template_file.cloud_config.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.docker.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.git.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.aws.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.terraform.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.certbot.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.run.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.motd.rendered
  }
}

data "template_file" "cloud_config" {
  template = file("cloudinit/cloud_config")
  vars = {
    instance_name = var.instance_name
    domain_name   = var.domain
    aws_access_key_id = var.iam_access_key_id
    aws_secret_access_key = data.aws_ssm_parameter.aws_access_key.value
    region = var.region
    user = var.os_user
  }
}

data "template_file" "git" {
  template = file("cloudinit/git.sh")

  vars = {
    user = var.os_user
  }
}

data "template_file" "docker" {
  template = file("cloudinit/docker.sh")

  vars = {
    user    = var.os_user
    version = "1.23.2"
  }
}

data "template_file" "aws" {
  template = file("cloudinit/aws.sh")

  vars = {
    user   = var.os_user
    region = var.region
  }
}

data "template_file" "terraform" {
  template = file("cloudinit/terraform.sh")

  vars = {
    version = "0.12.3"
  }
}

data "template_file" "certbot" {
  template = file("cloudinit/certbot.sh")

  vars = {
    hostmaster_email = "webmaster@tikal.io"
    instance_name    = var.instance_name
    domain_name      = var.domain
  }
}

data "template_file" "motd" {
  template = file("cloudinit/motd.sh")

  vars = {
    instance_name = var.instance_name
  }
}

data "template_file" "run" {
  template = file("cloudinit/run.sh")

  vars = {
    user = var.os_user
  }
}
