variable "project_id" {
  type        = string
  description = "Project ID for landing zone."
}

variable "env" {
  type        = string
  description = "Defines the environment."
}

variable "environment_code" {
  type        = string
  description = "A short form of the folder level resources (environment) within the Google Cloud organization."
}

variable "subnet_region_1" {
    type = string
    description = "Region where the subnets are going to be created."
}

variable "subnet_region_2" {
    type = string
    description = "Region where the subnets are going to be created."
}

/***************************
  VPC Connectivity
***************************/
variable "vpc_connectivity_subnet_1_ip" {
  type        = string
  description = "The network IP address in CIDR of first subnets in connctivity vpc."
}

variable "vpc_connectivity_subnet_2_ip" {
  type        = string
  description = "The network IP address in CIDR of second subnets in connctivity vpc."
}

/***************************
  VPC External
***************************/
variable "vpc_external_subnet_1_ip" {
  type        = string
  description = "The network IP address in CIDR of first subnets in external vpc."
}

variable "vpc_external_subnet_2_ip" {
  type        = string
  description = "The network IP address in CIDR of second subnets in external vpc."
}

/***************************
  VPC Internal
***************************/
variable "vpc_internal_subnet_1_ip" {
  type        = string
  description = "The network IP address in CIDR of first subnets in internal vpc."
}

variable "vpc_internal_subnet_2_ip" {
  type        = string
  description = "The network IP address in CIDR of second subnets in internal vpc."
}

/***************************
  Cloud Router
***************************/
variable "router_name_cr1" {
    type        = string
    description = "Name of the first Cloud Router in the landing zone."
}

variable "router_name_cr2" {
    type        = string
    description = "Name of the second Cloud Router in the landing zone."
}

variable "router_name_cr3" {
    type        = string
    description = "Name of the third Cloud Router in the landing zone."
}

variable "router_name_cr4" {
    type        = string
    description = "Name of the fourth Cloud Router in the landing zone."
}