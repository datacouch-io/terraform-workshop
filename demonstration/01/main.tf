locals {
  base_cidr = "10.0.0.0"
  vpc_cidr  = "${local.base_cidr}/16"
}

resource "aws_vpc" "demo_vpc" {
  cidr_block = local.vpc_cidr

  tags = {
    Name = "tf-example"
  }
}

resource "aws_subnet" "demo_subnet" {
  vpc_id            = aws_vpc.demo_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_network_interface" "demo_eni" {
  subnet_id   = aws_subnet.demo_subnet.id
  private_ips = ["10.0.0.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "foo" {
  ami           = data.aws_ami.latest_ubuntu.image_id
  instance_type = var.instance_type

  network_interface {
    network_interface_id = aws_network_interface.demo_eni.id
    device_index         = 0
  }

  tags = {
    Name = "tf-example-instance"
  }
}
