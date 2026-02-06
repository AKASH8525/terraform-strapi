resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub")

  tags = {
    Name        = "${var.project_name}-key"
    Environment = var.environment
  }
}
