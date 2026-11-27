output "vpc_id" {
  value = module.platform.vpc_id
}

output "public_subnet_ids" {
  value = module.platform.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.platform.private_subnet_ids
}

output "cluster_name" {
  value = module.platform.cluster_name
}

output "cluster_endpoint" {
  value = module.platform.cluster_endpoint
}

output "ecr_repository_url" {
  value = module.platform.ecr_repository_url
}

output "oidc_provider_arn" {
  value = module.platform.oidc_provider_arn
}
