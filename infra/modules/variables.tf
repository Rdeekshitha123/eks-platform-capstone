variable "name" {
  type        = string
}

variable "vpc_cidr" {
  type        = string
}

variable "instance_tenancy" {
  type    = string
  default = "default"
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "public_subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "private_subnets" {
    type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "public_ip_on_launch" {
  type        = bool
  default     = false
}

variable "public_subnet_tags" {
  type        = map(string)
  default     = {}
}

variable "private_subnet_tags" {
  type        = map(string)
  default     = {}
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS control plane. Check supported: aws eks describe-cluster-versions"
  type        = string
}

variable "endpoint_private_access" {
  description = "Allow access to the API server from inside the VPC"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Allow access to the API server from the internet (needed to run kubectl from your laptop)"
  type        = bool
  default     = true
}

variable "public_access_cidrs" {
  description = "CIDR blocks allowed to reach the public API endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "authentication_mode" {
  description = "Cluster authentication mode: API, API_AND_CONFIG_MAP or CONFIG_MAP"
  type        = string
  default     = "API"
}

variable "enabled_cluster_log_types" {
  description = "Control plane log types to send to CloudWatch (empty = none, no extra cost)"
  type        = list(string)
  default     = []
}
