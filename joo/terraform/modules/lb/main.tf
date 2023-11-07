################################################################################
# Load Balancer
################################################################################

resource "aws_lb" "this" {
  load_balancer_type                          = var.load_balancer_type
  name                                        = "lb-public"
  security_groups                             = [aws_security_group.lb.id]
  subnets                    = var.multi_az ? var.azs : [var.azs[0]]
  tags = merge(
    { "Name" = "${var.name}-was-launch-template" },
    var.tags
  )
}

################################################################################
# Security Group
################################################################################

resource "aws_security_group" "lb" {
  name        = "${var.name}-lb-sg"
  description = "${var.name}-lb-sg"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.lb_sg_ports
    content {
      description = "Allow ${ingress.key}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
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
    { "Name" = "${var.name}-lb-sg" },
    var.tags
  )
}