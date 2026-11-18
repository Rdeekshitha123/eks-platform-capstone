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
