resource "aws_instance" "chaos_master" {
  user_data              = data.template_cloudinit_config.cloundinit_config.rendered
  iam_instance_profile   = aws_iam_instance_profile.iam_instance_profile.name
  vpc_security_group_ids = [aws_security_group.chaos_master_sg.id]
  subnet_id              = var.subnet_id
  ami                    = var.ami_id
  availability_zone      = var.az
  instance_type          = var.instance_type
  key_name               = var.ssh_keypair_name

  root_block_device {
    volume_type = "gp2"
    volume_size = var.volume_size
  }

  tags = merge(
    local.common_tags,
    map("Name", var.instance_name)
  )
}

data "aws_eip" "eip" {
  tags = {
    Name = "${terraform.workspace}-chaos-master"
  }
}

resource "aws_eip_association" "eip_association" {
  instance_id   = aws_instance.chaos_master.id
  allocation_id = data.aws_eip.eip.id
}
