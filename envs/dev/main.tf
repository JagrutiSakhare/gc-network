/**
 * Copyright 2020 Google LLC
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

locals {
  environment_code          = "d"
  env                       = "dev"
  landing_zone_project_id   = data.google_projects.landing_zone_project.projects[0].project_id
  parent_id                 = var.parent_folder != "" ? "folders/${var.parent_folder}" : "organizations/${var.org_id}"
}

/******************************************
 Landing Zone
*****************************************/
module "landing_zone" {
  source           = "../../modules/landing_zone"
  project_id       = local.landing_zone_project_id
  env              = local.env                 
  environment_code = local.environment_code
  
  subnet_region_1 = var.default_region1
  subnet_region_2 = var.default_region2

  vpc_connectivity_subnet_1_ip = var.vpc_connectivity_subnet_1_ip
  vpc_connectivity_subnet_2_ip = var.vpc_connectivity_subnet_2_ip

  vpc_external_subnet_1_ip = var.vpc_external_subnet_1_ip
  vpc_external_subnet_2_ip = var.vpc_external_subnet_2_ip

  vpc_internal_subnet_1_ip = var.vpc_internal_subnet_1_ip
  vpc_internal_subnet_2_ip = var.vpc_internal_subnet_2_ip

  router_name_cr1 = var.router_name_cr1
  router_name_cr2 = var.router_name_cr2
  router_name_cr3 = var.router_name_cr3
  router_name_cr4 = var.router_name_cr4
}
