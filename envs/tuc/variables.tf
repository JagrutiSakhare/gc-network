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

variable "org_id" {
  type        = string
  description = "Organization ID"
}

variable "access_context_manager_policy_id" {
  type        = number
  description = "The id of the default Access Context Manager policy created in step `1-org`. Can be obtained by running `gcloud access-context-manager policies list --organization YOUR-ORGANIZATION_ID --format=\"value(name)\"`."
}

variable "terraform_service_account" {
  type        = string
  description = "Service account email of the account to impersonate to run Terraform."
}

variable "default_region1" {
  type        = string
  description = "First subnet region. The shared vpc modules only configures two regions."
}

variable "default_region2" {
  type        = string
  description = "Second subnet region. The shared vpc modules only configures two regions."
}

variable "domain" {
  type        = string
  description = "The DNS name of peering managed zone, for instance 'example.com.'"
}

variable "dns_enable_logging" {
  type        = bool
  description = "Toggle DNS logging for VPC DNS."
  default     = true
}

variable "subnetworks_enable_logging" {
  type        = bool
  description = "Toggle subnetworks flow logging for VPC Subnetwoks."
  default     = true
}

variable "firewall_enable_logging" {
  type        = bool
  description = "Toggle firewall logginglogging for VPC Firewalls."
  default     = true
}

variable "dns_enable_inbound_forwarding" {
  type        = bool
  description = "Toggle inbound query forwarding for VPC DNS."
  default     = true
}

variable "windows_activation_enabled" {
  type        = bool
  description = "Enable Windows license activation for Windows workloads."
  default     = false
}

variable "nat_enabled" {
  type        = bool
  description = "Toggle creation of NAT cloud router."
  default     = false
}

variable "nat_bgp_asn" {
  type        = number
  description = "BGP ASN for first NAT cloud routes."
  default     = 64514
}

variable "nat_num_addresses_region1" {
  type        = number
  description = "Number of external IPs to reserve for first Cloud NAT."
  default     = 2
}

variable "nat_num_addresses_region2" {
  type        = number
  description = "Number of external IPs to reserve for second Cloud NAT."
  default     = 2
}

variable "nat_num_addresses" {
  type        = number
  description = "Number of external IPs to reserve for Cloud NAT."
  default     = 2
}

variable "optional_fw_rules_enabled" {
  type        = bool
  description = "Toggle creation of optional firewall rules: IAP SSH, IAP RDP and Internal & Global load balancing health check and load balancing IP ranges."
  default     = false
}

variable "parent_folder" {
  description = "Optional - if using a folder for testing."
  type        = string
  default     = ""
}

/***************************************************************
  Landing Zone module variables
 **************************************************************/
# VPC - Connectivity
variable "vpc_connectivity_subnet_1_ip" {
  type        = string
  description = "The network IP address in CIDR of first subnets in connctivity vpc."
}

variable "vpc_connectivity_subnet_2_ip" {
  type        = string
  description = "The network IP address in CIDR of second subnets in connctivity vpc."
}

# VPC - External
variable "vpc_external_subnet_1_ip" {
  type        = string
  description = "The network IP address in CIDR of first subnets in external vpc."
}

variable "vpc_external_subnet_2_ip" {
  type        = string
  description = "The network IP address in CIDR of second subnets in external vpc."
}

# VPC - Internal
variable "vpc_internal_subnet_1_ip" {
  type        = string
  description = "The network IP address in CIDR of first subnets in internal vpc."
}

variable "vpc_internal_subnet_2_ip" {
  type        = string
  description = "The network IP address in CIDR of second subnets in internal vpc."
}

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

# shared vpc and service project variable

variable "folder_id" {
  description = "The folder to create projects in"
}

variable "billing_account" {
  description = "The ID of the billing account to associate this project with"
}

variable "host_project_name" {
  description = "Name for Shared VPC host project"
  default     = ""
}

variable "dmz_host_project_id" {
  description = "ID for Shared VPC host project"
  default     = ""
}
variable "non_internet_host_project_id" {
  description = "ID for Shared VPC host project with no internet"
  default     = ""
}

variable "service_project_name_1" {
  description = "Name for DMZ Shared VPC service project "
  default     = ""
}
variable "service_project_name_2" {
  description = "Name for non-internet Shared VPC service project"
  default     = ""
}

variable "dmz_vpc" {
  description = "Name for DMZ VPC network"
  default     = ""
}
variable "non-internet-vpc" {
  description = "Name for non-internet VPC network"
  default     = ""
}

variable "organization_id" {
  description = "The organization id for the associated services"
}

variable "base_project_number" {
  description = "non-internet project number"
  default     = ""
}

variable "landing_project_number" {
  description = "Landing project number"
  default     = ""
}
variable "restricted_project_number" {
  description = "DMZ project number"
  default     = ""
}
variable "dmz_subnet_range_01" {
  type        = string
  description = "The network IP address in CIDR of prod dmz vpc."
  default     = ""
}
variable "dmz_subnet_range_02" {
  type        = string
  description = "The network IP address in CIDR of prod dmz vpc."
  default     = ""
}
variable "dmz_sec_subnet_range_01_01" {
  type        = string
  description = "The network IP address in CIDR of prod dmz vpc."
  default     = ""
}
variable "dmz_sec_subnet_range_01_02" {
  type        = string
  description = "The network IP address in CIDR of prod dmz vpc."
  default     = ""
}
variable "dmz_sec_subnet_range_02_01" {
  type        = string
  description = "The network IP address in CIDR of prod dmz vpc."
  default     = ""
}
variable "non_in_subnet_range_01" {
  type        = string
  description = "The network IP address in CIDR of prod dmz vpc."
  default     = ""
}
variable "non_in_subnet_range_02" {
  type        = string
  description = "The network IP address in CIDR of prod dmz vpc."
  default     = ""
}
variable "non_in_sec_subnet_range_01_01" {
  type        = string
  description = "The network IP address in CIDR of prod dmz vpc."
  default     = ""
}
variable "non_in_sec_subnet_range_01_02" {
  type        = string
  description = "The network IP address in CIDR of prod dmz vpc."
  default     = ""
}
variable "non_in_sec_subnet_range_02_01" {
  type        = string
  description = "The network IP address in CIDR of prod dmz vpc."
  default     = ""
}