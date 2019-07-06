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
    content      = data.template_file.motd.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.run.rendered
  }
}

data "template_file" "cloud_config" {
  template = file("cloudinit/cloud_config")
  vars = {
    jenkins_url = "chaos-jenkins.fuse.tikal.io"
  }
}

data "template_file" "git" {
  template = file("cloudinit/git.sh")

  vars = {
    user = "ec2-user"
  }
}

data "template_file" "docker" {
  template = file("cloudinit/docker.sh")

  vars = {
    user    = "ec2-user"
    version = "1.23.2"
  }
}

data "template_file" "aws" {
  template = file("cloudinit/aws.sh")

  vars = {
    user   = "ec2-user"
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
    jenkins_url      = "chaos-jenkins.fuse.tikal.io"
  }
}

data "template_file" "motd" {
  template = file("cloudinit/motd.sh")

  vars = {
    shortname = "chaos-jenkins"
  }
}

data "template_file" "run" {
  template = file("cloudinit/run.sh")

  vars = {
    user   = "ec2-user"
  }
}
