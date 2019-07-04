resource "aws_security_group" "jenkins_chaos_master_sg" {
  name        = "jenkins-chaos-master-sg"
  description = "Jenkins chaos master secutity group"
  vpc_id      = "vpc-5835d531"

  tags = merge(
    local.common_tags,
    map("Name", "jenkins-chaos-master-sg")
  )
}

resource "aws_security_group_rule" "egr_all" {
  security_group_id = aws_security_group.jenkins_chaos_master_sg.id
  type              = "egress"
  protocol          = "all"
  from_port         = 0
  to_port           = 65535
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ing_tcp22" {
  security_group_id = aws_security_group.jenkins_chaos_master_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["195.182.33.5/32"]
  description       = "corp"
}

resource "aws_security_group_rule" "ing_tcp8080" {
  security_group_id = aws_security_group.jenkins_chaos_master_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 8080
  to_port           = 8080
  cidr_blocks       = ["195.182.33.5/32"]
  description       = "corp"
}
