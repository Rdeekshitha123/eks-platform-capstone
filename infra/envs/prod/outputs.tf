output "vpc_id" {
  value = module.platform.vpc_id
}

output "public_subnet_ids" {
  value = module.platform.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.platform.private_subnet_ids
}
