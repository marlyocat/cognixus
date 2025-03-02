resource "aws_lb" "gitea_alb" {
  name               = "gitea-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.gitea_security_group.id]
  subnets            = [for subnet in aws_subnet.gitea_public_subnet : subnet.id]
}

resource "aws_lb_target_group" "gitea_alb_target_group" {
  name     = "gitea-alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.gitea_vpc.id
}

resource "aws_lb_target_group_attachment" "gitea_alb_target_group_attachment" {
  for_each = { for idx, instance in aws_instance.gitea_app : idx => instance }

  target_group_arn = aws_lb_target_group.gitea_alb_target_group.arn
  target_id        = each.value.id
  port             = 80
}

resource "aws_lb_listener" "gitea_alb_http_redirect" {
  load_balancer_arn = aws_lb.gitea_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "gitea_alb_https" {
  load_balancer_arn = aws_lb.gitea_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:ap-southeast-1:390844738809:certificate/bb4fd335-d5a3-48ff-9340-9468c3c8ecf4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.gitea_alb_target_group.arn
  }
}