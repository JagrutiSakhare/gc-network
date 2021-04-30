module "cloud_router_cr1" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "0.4.0"
  
  name    = "${var.env}-01-${local.con_vpc_name}-${var.router_name_cr1}"
  project = var.project_id
  region  = var.subnet_region_1
  network = module.vpc_connectivity.network_name
}

module "cloud_router_cr2" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "0.4.0"
  
  name    = "${var.env}-01-${local.con_vpc_name}-${var.router_name_cr2}"
  project = var.project_id
  region  = var.subnet_region_1
  network = module.vpc_connectivity.network_name
}

module "cloud_router_cr3" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "0.4.0"
  
  name    = "${var.env}-01-${local.con_vpc_name}-${var.router_name_cr3}"
  project = var.project_id
  region  = var.subnet_region_2
  network = module.vpc_connectivity.network_name
}

module "cloud_router_cr4" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "0.4.0"
  
 name    = "${var.env}-01-${local.con_vpc_name}-${var.router_name_cr4}"
  project = var.project_id
  region  = var.subnet_region_2
  network = module.vpc_connectivity.network_name
}
