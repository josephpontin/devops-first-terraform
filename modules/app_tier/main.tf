# These are the resources particular to the app tier


# Create a subnet
resource "aws_subnet" "app_subnet"{
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = var.instance_name
  }
}

# Route Table
resource "aws_route_table" "app_route_table"{
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.ig_id
  }
  tags = {
    Name = var.instance_name
  }
}

# Route Table Associations
resource "aws_route_table_association" "app_assoc"{
  subnet_id = aws_subnet.app_subnet.id
  route_table_id = aws_route_table.app_route_table.id
}

# Create security group
resource "aws_security_group" "app_sg" {
  vpc_id        = var.vpc_id
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["212.161.55.68/32"]
  }
  ingress {
    from_port = 3000
    to_port   = 3000
    protocol  = "tcp"
    cidr_blocks = ["212.161.55.68/32"]
  }
  tags = {
    Name = var.instance_name
  }
}

# Launch an instance
resource "aws_instance" "app_instance"{
  ami                            = var.ami_id
  key_name                       = "joseph-eng-48-first-key"
  vpc_security_group_ids         = ["${aws_security_group.app_sg.id}"]
  subnet_id                      = aws_subnet.app_subnet.id
  instance_type                  = "t2.micro"
  associate_public_ip_address    = true
  user_data                      = data.template_file.app_init.rendered
  tags                           = {Name = var.instance_name}
}

## DATA ##########################################################

# Send template .sh to instance
data "template_file" "app_init"{
  template = file("./scripts/init_script.sh.tpl")
}
