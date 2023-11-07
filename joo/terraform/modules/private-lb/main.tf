################################################################################
# Load Balancer
################################################################################

resource "aws_lb" "private" {
  internal           = true
  load_balancer_type                          = var.load_balancer_type
  name                                        = "private-lb"
  security_groups                             = [aws_security_group.private_lb.id]
  subnets                    = var.private_lb_subnets
  tags = merge(
    { "Name" = "${var.name}-private-lb" },
    var.tags
  )
}

/*
################################################################################
# Target Group(s)
################################################################################

resource "aws_lb_target_group" "this" {
  for_each = { for k, v in var.target_groups : k => v if local.create }

  connection_termination = try(each.value.connection_termination, null)
  deregistration_delay   = try(each.value.deregistration_delay, null)

  dynamic "health_check" {
    for_each = try([each.value.health_check], [])

    content {
      enabled             = try(health_check.value.enabled, null)
      healthy_threshold   = try(health_check.value.healthy_threshold, null)
      interval            = try(health_check.value.interval, null)
      matcher             = try(health_check.value.matcher, null)
      path                = try(health_check.value.path, null)
      port                = try(health_check.value.port, null)
      protocol            = try(health_check.value.protocol, null)
      timeout             = try(health_check.value.timeout, null)
      unhealthy_threshold = try(health_check.value.unhealthy_threshold, null)
    }
  }

  ip_address_type                    = try(each.value.ip_address_type, null)
  lambda_multi_value_headers_enabled = try(each.value.lambda_multi_value_headers_enabled, null)
  load_balancing_algorithm_type      = try(each.value.load_balancing_algorithm_type, null)
  load_balancing_cross_zone_enabled  = try(each.value.load_balancing_cross_zone_enabled, null)
  name                               = try(each.value.name, null)
  name_prefix                        = try(each.value.name_prefix, null)
  port                               = try(each.value.target_type, null) == "lambda" ? null : try(each.value.port, var.default_port)
  preserve_client_ip                 = try(each.value.preserve_client_ip, null)
  protocol                           = try(each.value.target_type, null) == "lambda" ? null : try(each.value.protocol, var.default_protocol)
  protocol_version                   = try(each.value.protocol_version, null)
  proxy_protocol_v2                  = try(each.value.proxy_protocol_v2, null)
  slow_start                         = try(each.value.slow_start, null)

  dynamic "stickiness" {
    for_each = try([each.value.stickiness], [])

    content {
      cookie_duration = try(stickiness.value.cookie_duration, null)
      cookie_name     = try(stickiness.value.cookie_name, null)
      enabled         = try(stickiness.value.enabled, true)
      type            = var.load_balancer_type == "network" ? "source_ip" : stickiness.value.type
    }
  }

  dynamic "target_failover" {
    for_each = try(each.value.target_failover, [])

    content {
      on_deregistration = target_failover.value.on_deregistration
      on_unhealthy      = target_failover.value.on_unhealthy
    }
  }

  dynamic "target_health_state" {
    for_each = try([each.value.target_health_state], [])
    content {
      enable_unhealthy_connection_termination = try(target_health_state.value.enable_unhealthy_connection_termination, true)
    }
  }

  target_type = try(each.value.target_type, null)
  vpc_id      = try(each.value.vpc_id, var.vpc_id)

  tags = merge(local.tags, try(each.value.tags, {}))

  lifecycle {
    create_before_destroy = true
  }
}

################################################################################
# Target Group Attachment
################################################################################

resource "aws_lb_target_group_attachment" "this" {
  for_each = { for k, v in var.target_groups : k => v if local.create && lookup(v, "create_attachment", true) }

  target_group_arn  = aws_lb_target_group.this[each.key].arn
  target_id         = each.value.target_id
  port              = try(each.value.target_type, null) == "lambda" ? null : try(each.value.port, var.default_port)
  availability_zone = try(each.value.availability_zone, null)

  depends_on = [aws_lambda_permission.this]
}
*/

################################################################################
# Security Group
################################################################################

resource "aws_security_group" "private_lb" {
  name        = "${var.name}-private-lb-sg"
  description = "${var.name}-private-lb-sg"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.private_lb_sg_ports
    content {
      description = "Allow ${ingress.key}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      security_groups = [var.web_sg_id]
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
    { "Name" = "${var.name}-private-lb-sg" },
    var.tags
  )
}