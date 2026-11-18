output "vpc_id" {
  value = aws_vpc.eks_vpc.id
}

output "public_subnet_ids" {
  value = [for s in aws_subnet.eks_public_subnet : s.id]
}

output "private_subnet_ids" {
  value = [for s in aws_subnet.eks_private_subnet : s.id]
}

output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "cluster_arn" {
  value = aws_eks_cluster.eks_cluster.arn
}

output "cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "cluster_oidc_issuer" {
  value = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}
