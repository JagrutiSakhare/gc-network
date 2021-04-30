locals {
  component    = "landing-tier"
  con_vpc_name = "con-vpc01"
  ext_vpc_name = "ext-vpc01"
  int_vpc_name = "int-vpc01"
  routing_mode = "GLOBAL"
}

/***************************************************************
  Connectivity VPC
 **************************************************************/
module "vpc_connectivity" {
  source  = "terraform-google-modules/network/google"
  version = "~> 3.1"

  project_id   = var.project_id
  network_name = "${var.env}-01-${local.con_vpc_name}"
  routing_mode = local.routing_mode

  subnets = [
      {
          subnet_name   = "${var.env}-01-${local.con_vpc_name}-${local.component}-w301"
          subnet_ip     = var.vpc_connectivity_subnet_1_ip
          subnet_region = var.subnet_region_1
      },{
          subnet_name   = "${var.env}-01-${local.con_vpc_name}-${local.component}-w401"
          subnet_ip     = var.vpc_connectivity_subnet_2_ip
          subnet_region = var.subnet_region_2
      }
  ]

  # TODO: Implement routes for connecktivity VPC here.
  # routes = []

  # TODO: Implement firewall_rules for connecktivity VPC here.
  # firewall_rules = []
}

/***************************************************************
  External VPC
 **************************************************************/
module "vpc_external" {
  source  = "terraform-google-modules/network/google"
  version = "~> 3.1"

  project_id   = var.project_id
  network_name = "${var.env}-01-${local.ext_vpc_name}"
  routing_mode = local.routing_mode

  subnets = [
      {
          subnet_name   = "${var.env}-01-${local.ext_vpc_name}-${local.component}-w301"
          subnet_ip     = var.vpc_external_subnet_1_ip
          subnet_region = var.subnet_region_1
      },{
          subnet_name   = "${var.env}-01-${local.ext_vpc_name}-${local.component}-w401"
          subnet_ip     = var.vpc_external_subnet_2_ip
          subnet_region = var.subnet_region_2
      }
  ]

  # TODO: Implement routes for connecktivity VPC here.
  # routes = []

  # TODO: Implement firewall_rules for connecktivity VPC here.
  # firewall_rules = []
}

/***************************************************************
  Internal VPC
 **************************************************************/
module "vpc_internal" {
  source  = "terraform-google-modules/network/google"
  version = "~> 3.1"

  project_id   = var.project_id
  network_name = "${var.env}-01-${local.int_vpc_name}"
  routing_mode = local.routing_mode

  subnets = [
      {
          subnet_name   = "${var.env}-01-${local.int_vpc_name}-${local.component}-w301"
          subnet_ip     = var.vpc_internal_subnet_1_ip
          subnet_region = var.subnet_region_1
      },{
          subnet_name   = "${var.env}-01-${local.int_vpc_name}-${local.component}-w401"
          subnet_ip     = var.vpc_internal_subnet_2_ip
          subnet_region = var.subnet_region_2
      }
  ]

  # TODO: Implement routes for connecktivity VPC here.
  # routes = []

  # TODO: Implement firewall_rules for connecktivity VPC here.
  # firewall_rules = []
}
