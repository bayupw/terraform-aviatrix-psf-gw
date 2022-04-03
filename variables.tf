variable "gw_name" {
  description = "Name for this psf gateway"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy this module in"
  type        = string
}

variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
}

variable "cidr" {
  description = "The CIDR range to be used for the VPC"
  type        = string
  default     = ""
}

variable "account" {
  description = "The AWS account name, as known by the Aviatrix controller"
  type        = string
}

variable "instance_size" {
  description = "AWS Instance size for the Aviatrix psf gateways"
  type        = string
  default     = "t2.micro"
}

variable "route_table_ids" {
  description = "Route table ids whose associated public subnets will be protected by the primary gateway"
  type        = list(string)
  default     = []
}

variable "ha_route_table_ids" {
  description = "Route table ids whose associated public subnets will be protected by the HA gateway."
  type        = list(string)
  default     = []
}

variable "ha_gw" {
  description = "Boolean to determine if module will be deployed in HA or single mode"
  type        = bool
  default     = true
}

variable "az1" {
  description = "Concatenates with region to form az names. e.g. eu-central-1a. Only used for insane mode"
  type        = string
  default     = "a"
}

variable "az2" {
  description = "Concatenates with region to form az names. e.g. eu-central-1b. Only used for insane mode"
  type        = string
  default     = "b"
}

variable "active_mesh" {
  description = "Set to false to disable active mesh."
  type        = bool
  default     = true
}

variable "single_az_ha" {
  description = "Set to true if Controller managed Gateway HA is desired"
  type        = bool
  default     = true
}

variable "guard_duty_enforced" {
  description = "Set to true to enforce AWS Guard Duty"
  type        = bool
  default     = true
}

variable "enable_encrypt_volume" {
  description = "Set to true to enable volume encryption"
  type        = bool
  default     = true
}

# copied from https://github.com/aviatrix-automation/aws-psf-ingress-example
locals {
  cidrbits  = tonumber(split("/", var.cidr)[1])
  newbits   = 26 - local.cidrbits
  netnum    = pow(2, local.newbits)
  subnet    = cidrsubnet(var.cidr, local.newbits, local.netnum - 2)
  ha_subnet = cidrsubnet(var.cidr, local.newbits, local.netnum - 1)
}