// Global
locals {
  azs = data.aws_availability_zones.available.names
}

data "aws_availability_zones" "available" {}

// VPC
resource "aws_vpc" "gitea_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "gitea-vpc"
  }
  lifecycle {
    create_before_destroy = true
  }
}

// VPC Subnets
resource "aws_subnet" "gitea_public_subnet" {
  count                   = length(local.azs)
  vpc_id                  = aws_vpc.gitea_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = local.azs[count.index]

  tags = {
    Name = "gitea-public-subnet-${count.index + 1}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "gitea_private_subnet" {
  count                   = length(local.azs)
  vpc_id                  = aws_vpc.gitea_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, length(local.azs) + count.index)
  map_public_ip_on_launch = false
  availability_zone       = local.azs[count.index]

  tags = {
    Name = "gitea-private-subnet-${count.index + 1}"
  }
}

// Internet Gateway
resource "aws_internet_gateway" "gitea_internet_gateway" {
  vpc_id = aws_vpc.gitea_vpc.id

  tags = {
    Name = "gitea-internet-gateway"
  }
}

// Route Table
resource "aws_route" "gitea_default_route" {
  route_table_id         = aws_route_table.gitea_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gitea_internet_gateway.id
}

resource "aws_route_table" "gitea_public_route_table" {
  vpc_id = aws_vpc.gitea_vpc.id

  tags = {
    Name = "gitea-public-route-table"
  }
}

resource "aws_default_route_table" "gitea_private_route_table" {
  default_route_table_id = aws_vpc.gitea_vpc.default_route_table_id

  tags = {
    Name = "gitea-private-route-table"
  }
}

// VPC Subnet Associations
resource "aws_route_table_association" "gitea_public_association" {
  count          = length(local.azs)
  subnet_id      = aws_subnet.gitea_public_subnet[count.index].id
  route_table_id = aws_route_table.gitea_public_route_table.id
}

// Security Group
resource "aws_security_group" "gitea_security_group" {
  name        = "gitea_public_security_group"
  description = "Security group for Gitea public instances"
  vpc_id      = aws_vpc.gitea_vpc.id
}

// Security Group Rules
resource "aws_security_group_rule" "gitea_ingress" {
  for_each = toset(["80", "443"])

  type              = "ingress"
  from_port         = tonumber(each.value)
  to_port           = tonumber(each.value)
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gitea_security_group.id
}

resource "aws_security_group_rule" "gitea_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gitea_security_group.id
}