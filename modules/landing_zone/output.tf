output "vpc_connectivity_network" {
  value = module.vpc_connectivity.network
}

output "vpc_connectivity_network_name" {
  value = module.vpc_connectivity.network_name
}

output "vpc_connectivity_name" {
  value = module.vpc_connectivity.network_self_link
}

output "project_id" {
  value = module.vpc_connectivity.project_id
}

output "vpc_connectivity_network_self_link" {
  value = module.vpc_connectivity.network_self_link
}

output "vpc_connectivity_route_names" {
  value = module.vpc_connectivity.route_names
}

output "vpc_connectivity_subnets" {
  value = module.vpc_connectivity.subnets
}

output "vpc_connectivity_subnets_flow_logs" {
  value = module.vpc_connectivity.subnets_flow_logs
}

output "vpc_connectivity_subnets_ips" {
  value = module.vpc_connectivity.subnets_ips
}

output "vpc_connectivity_subnets_names" {
  value = module.vpc_connectivity.subnets_names
}

output "vpc_connectivity_subnets_private_access" {
  value = module.vpc_connectivity.subnets_private_access
}

output "vpc_connectivity_subnets_regions" {
  value = module.vpc_connectivity.subnets_regions
}

output "vpc_connectivity_subnets_secondary_ranges" {
  value = module.vpc_connectivity.subnets_secondary_ranges
}

output "vpc_connectivity_subnets_self_links" {
  value = module.vpc_connectivity.subnets_self_links
}
