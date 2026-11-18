output "vpc_id" {
  value = aws_vpc.eks_vpc.id
}

output "public_subnet_ids" {
  value = [for s in aws_subnet.eks_public_subnet : s.id]
}

output "private_subnet_ids" {
  value = [for s in aws_subnet.eks_private_subnet : s.id]
}
