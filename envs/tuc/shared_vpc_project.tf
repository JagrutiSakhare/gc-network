/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


data "google_projects" "project_non_internet" {
  filter = "parent.id:${split("/", data.google_active_folder.env.name)[1]} labels.application_name=non_internet_host labels.environment=${local.env} lifecycleState=ACTIVE"
}


data "google_projects" "project_prod_dmz" {
  filter = "parent.id:${split("/", data.google_active_folder.env.name)[1]} labels.application_name=dmz-host labels.environment=${local.env} lifecycleState=ACTIVE"
}



locals {
  dmz_host_project_id = data.google_projects.project_prod_dmz.projects[0].project_id
  non_internet_host_project_id = data.google_projects.project_non_internet.projects[0].project_id
  dmz_subnet_01 = "${local.env}-01-svpc01-sub-appx-w301"
  dmz_subnet_02 = "${local.env}-01-svpc01-sub-appx-w401"
  non_in_subnet_01 = "${local.env}-02-svpc01-sub-appy-w301"
  non_in_subnet_02 = "${local.env}-02-svpc01-sub-appy-w401"
}

/******************************************
  Provider configuration
 *****************************************/
provider "null" {
  version = "~> 2.1"
}

provider "random" {
  version = "~> 2.2"
}

/******************************************
  Host Project enabling
 *****************************************/
resource "google_compute_shared_vpc_host_project" "host_dmz" {
  project = local.dmz_host_project_id
}

resource "google_compute_shared_vpc_host_project" "host_non_internet" {
  project = local.non_internet_host_project_id
}


/******************************************
  Network Creation
 *****************************************/
module "dmz-vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 2.5.0"

  project_id                             = local.dmz_host_project_id
  network_name                           = "${local.env}-01-svpc01"
  delete_default_internet_gateway_routes = true

  subnets = [
    {
      subnet_name   = local.dmz_subnet_01
      subnet_ip     = var.dmz_subnet_range_01
      subnet_region = var.default_region1
      subnet_private_access = true
      subnet_flow_logs      = false
    },
    {
      subnet_name           = local.dmz_subnet_02
      subnet_ip             = var.dmz_subnet_range_02
      subnet_region         = var.default_region2
      subnet_private_access = true
      subnet_flow_logs      = false
    },
  ]
/* # Will be used for secondary ranges
  secondary_ranges = {
    (local.dmz_subnet_01) = [
      {
        range_name    = "${local.dmz_subnet_01}-01"
        ip_cidr_range = var.dmz_sec_subnet_range_01_01
      },
      {
        range_name    = "${local.dmz_subnet_01}-02"
        ip_cidr_range = var.dmz_sec_subnet_range_01_02
      },
    ]
    (local.dmz_subnet_02) = [
      {
        range_name    = "${local.dmz_subnet_02}-01"
        ip_cidr_range = var.dmz_sec_subnet_range_02_01
      },
    ]
  } */
}
## Create shared VPC in non-internet Host project
module "non-internet-vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 2.5.0"

  project_id                             = local.non_internet_host_project_id
  network_name                           = "${local.env}-02-svpc01"
  delete_default_internet_gateway_routes = true

  subnets = [
    {
      subnet_name   = local.non_in_subnet_01
      subnet_ip     = var.non_in_subnet_range_01
      subnet_region = var.default_region1
      subnet_private_access = true
      subnet_flow_logs      = false
    },
    {
      subnet_name           = local.non_in_subnet_02
      subnet_ip             = var.non_in_subnet_range_02
      subnet_region         = var.default_region2
      subnet_private_access = true
      subnet_flow_logs      = false
    },
  ]
/* # Will be used for secondary ranges
  secondary_ranges = {
    (local.non_in_subnet_01) = [
      {
        range_name    = "${local.non_in_subnet_01}-01"
        ip_cidr_range = var.non_in_sec_subnet_range_01_01
      },
      {
        range_name    = "${local.non_in_subnet_01}-02"
        ip_cidr_range = var.non_in_sec_subnet_range_01_02
      },
    ]

    (local.non_in_subnet_02) = [
      {
        range_name    = "${local.non_in_subnet_02}-01"
        ip_cidr_range = var.non_in_sec_subnet_range_02_01
      },
    ]
	*/
  }


/******************************************
  Service Project for DMZ project
 *****************************************/
module "service-project" {
  source = "../../modules/shared_service_projects/svpc_service_project"

  name              = var.service_project_name_1
  random_project_id = "true"

  org_id          = var.organization_id
  folder_id       = var.folder_id
  billing_account = var.billing_account

  shared_vpc         = local.dmz_host_project_id
  shared_vpc_subnets = module.dmz-vpc.subnets_self_links

  activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "dataproc.googleapis.com",
    "dataflow.googleapis.com",
  ]

  disable_services_on_destroy = "false"
  depends_on = [google_compute_shared_vpc_host_project.host_dmz]
}

/******************************************
  Service Project for non-internet project
 *****************************************/
module "service-project-b" {
  source = "../../modules/shared_service_projects/svpc_service_project"

  name              = var.service_project_name_2
  random_project_id = "true"

  org_id          = var.organization_id
  folder_id       = var.folder_id
  billing_account = var.billing_account

  shared_vpc = local.non_internet_host_project_id
  shared_vpc_subnets = module.non-internet-vpc.subnets_self_links

  activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "dataproc.googleapis.com",
  ]

  activate_api_identities = [{
    api = "healthcare.googleapis.com"
    roles = [
      "roles/healthcare.serviceAgent",
      "roles/bigquery.jobUser",
    ]
  }]

  disable_services_on_destroy = "false"
   depends_on = [google_compute_shared_vpc_host_project.host_non_internet]
}
