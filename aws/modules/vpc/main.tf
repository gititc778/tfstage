resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = {
    Name = "terraform-vpc-${random_string.suffix.result}"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.cidr_block, 4, 0)
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2a"

  tags = {
    Name = "terraform-public-${random_string.suffix.result}"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.cidr_block, 4, 1)
  availability_zone = "eu-west-2a"

  tags = {
    Name = "terraform-private-${random_string.suffix.result}"
  }
}
