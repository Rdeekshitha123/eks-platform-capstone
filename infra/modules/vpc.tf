locals {
  nat_subnet_key = sort(keys(var.public_subnets))[0]
}


resource "aws_vpc" "eks_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = "${var.name}-vpc"
  }
}

resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "${var.name}-igw"
  }
}

resource "aws_subnet" "eks_public_subnet" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = var.public_ip_on_launch

  tags = merge(var.public_subnet_tags, {
    Name = "${var.name}-${each.key}"
  })
}

resource "aws_route_table" "eks_public_rt" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }

  tags = {
    Name = "${var.name}-public-rt"
  }
}

resource "aws_route_table_association" "eks_public_rt_assoc" {
  for_each = aws_subnet.eks_public_subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.eks_public_rt.id
}

resource "aws_eip" "eks_nat_eip" {
  domain = "vpc"

  tags = {
    Name = "${var.name}-nat-eip"
  }
}

resource "aws_nat_gateway" "eks_nat" {
  allocation_id = aws_eip.eks_nat_eip.id
  subnet_id     = aws_subnet.eks_public_subnet[local.nat_subnet_key].id

  tags = {
    Name = "${var.name}-nat"
  }

  depends_on = [aws_internet_gateway.eks_igw]
}

resource "aws_subnet" "eks_private_subnet" {
  for_each = var.private_subnets

  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = false

  tags = merge(var.private_subnet_tags, {
    Name = "${var.name}-${each.key}"
  })
}

resource "aws_route_table" "eks_private_rt" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks_nat.id
  }

  tags = {
    Name = "${var.name}-private-rt"
  }
}

resource "aws_route_table_association" "eks_private_rt_assoc" {
  for_each = aws_subnet.eks_private_subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.eks_private_rt.id
}
