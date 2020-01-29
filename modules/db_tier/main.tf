resource "aws_security_group" "db_sg" {
  name = var.instance_name
  description = "Allow traffic from app"
  vpc_id = var.vpc_id

  ingress {
    from_port = 27017
    to_port = 27017
    protocol = "tcp"
    security_groups = ["${var.app_sg_id}"]
  }

  tags = {
    Name = var.instance_name
  }
}
