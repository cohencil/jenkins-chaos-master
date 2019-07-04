resource "aws_instance" "jenkins_chaos_master" {
  user_data              = data.template_cloudinit_config.cloundinit_config.rendered
  iam_instance_profile   = aws_iam_instance_profile.iam_instance_profile.name
  vpc_security_group_ids = [aws_security_group.jenkins_chaos_master_sg.id]
  subnet_id              = "subnet-c61f12be"
  ami                    = "ami-0cc293023f983ed53"
  availability_zone      = "eu-central-1b"
  instance_type          = "m5.large"
  key_name               = "jenkins-chaos-master"

  root_block_device {
    volume_type = "gp2"
    volume_size = "40"
  }

  tags = merge(
    local.common_tags,
    map("Name", local.instance_name)
  )
}

data "aws_eip" "eip" {
  tags = {
    Name = local.instance_name
  }
}

resource "aws_eip_association" "eip_association" {
  instance_id   = aws_instance.jenkins_chaos_master.id
  allocation_id = data.aws_eip.eip.id
}
