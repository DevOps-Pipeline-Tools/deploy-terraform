################################################################################
# Launch template
################################################################################

resource "aws_launch_template" "db" {
  name          = "${var.name}-db-launch-template"
  description   = "${var.name}-db-launch-template"
  instance_type = var.instance_type
  image_id      = data.aws_ami.amzlinux3.id
  key_name      = var.key_name
  user_data     = filebase64("${path.module}/db-install.sh")

  vpc_security_group_ids = aws_security_group.db[*].id

  tags = merge(
    { "Name" = "${var.name}-db-launch-template}" },
    var.tags
  )
}
################################################################################
# Autoscaling group
################################################################################

resource "aws_autoscaling_group" "this" {
  name = "${var.name}-db-asg"

  launch_template {
    id = aws_launch_template.db.id
  }

  vpc_zone_identifier       = var.multi_az ? var.vpc_zone_identifier : [var.vpc_zone_identifier[0]]
  min_size                  = var.multi_az ? 2 : 1 
  max_size                  = var.multi_az ? 4 : 2
  desired_capacity          = var.multi_az ? 2 : 1
  wait_for_capacity_timeout = var.wait_for_capacity_timeout

  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period

  tag {
      key = "Name"
      value   = "${var.name}-db"
      propagate_at_launch     = true   
  }

  tag {
      key = "Name"
      value   = lookup(var.tags, "Name")
      propagate_at_launch     = true   
  }
}

################################################################################
# Security Group
################################################################################

resource "aws_security_group" "db" {
  name        = "${var.name}-db-sg"
  description = "${var.name}-db-sg"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.db_sg_ports
    content {
      description = "Allow ${ingress.key}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.was_sg_id
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    { "Name" = "${var.name}-db-sg" },
    var.tags
  )
}