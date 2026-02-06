resource "aws_lb" "this" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public.id]

  tags = {
    Name        = "${var.project_name}-alb"
    Environment = var.environment
  }
}


resource "aws_lb_target_group" "this" {
  name     = "${var.project_name}-tg"
  port     = 1337
  protocol = "HTTP"
  vpc_id   = aws_vpc.this.id

  health_check {
    path                = "/"
    port                = "1337"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }

  tags = {
    Name        = "${var.project_name}-tg"
    Environment = var.environment
  }
}


resource "aws_lb_target_group_attachment" "ec2" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = aws_instance.private_ec2.id
  port             = 1337
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

