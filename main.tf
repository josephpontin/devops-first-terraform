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

# Call module to create app tier

module "app" {
  source = "./modules/app_tier"
  vpc_id = aws_vpc.app_vpc.id
  instance_name = var.instance_name
  ig_id = aws_internet_gateway.app_gw.id
  ami_id = var.ami_id
}

# Call module to create db tier
