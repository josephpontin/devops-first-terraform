# These are the resources particular to the db tier

# Create subnet
resource "aws_subnet" "db_subnet"{
  vpc_id = var.vpc_id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "${var.instance_name}-db"
  }
}

# Create sg
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

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = ["${var.app_sg_id}"]
  }

  tags = {
    Name = var.instance_name
  }
}

# Launch an instance
resource "aws_instance" "db_instance"{
  ami                            = var.ami_db_id
  key_name                       = "joseph-eng-48-first-key"
  vpc_security_group_ids         = ["${aws_security_group.db_sg.id}"]
  subnet_id                      = aws_subnet.db_subnet.id
  instance_type                  = "t2.micro"
  associate_public_ip_address    = true
  tags                           = {Name = "${var.instance_name}_db"}
}
