## PROVIDER #####################################################

# Set a provider
provider "aws"{
  region = "eu-west-1"
}

## RESOURCES ####################################################

# Create a VPC
resource "aws_vpc" "app_vpc"{
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = var.instance_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "app_gw" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name = var.instance_name
  }
}

# Create a subnet
resource "aws_subnet" "app_subnet"{
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = var.instance_name
  }
}

# Route Table
resource "aws_route_table" "app_route_table"{
  vpc_id = aws_vpc.app_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app_gw.id
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
resource "aws_security_group" "allow_80" {
  vpc_id        = aws_vpc.app_vpc.id
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.instance_name
  }
}

# Launch an instance
resource "aws_instance" "app_instance"{
  ami                            = var.ami_id
  vpc_security_group_ids         = ["${aws_security_group.allow_80.id}"]
  subnet_id                      = aws_subnet.app_subnet.id
  instance_type                  = "t2.micro"
  associate_public_ip_address    = true
  user_data                      = data.template_file.app_init.rendered
  tags                           = {Name = var.instance_name}
}

# Send template .sh to instance
data "template_file" "app_init"{
  template = file("./scripts/init_script.sh.tpl")
}
