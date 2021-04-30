data "google_compute_network" "prod-dmz" {
  name    = "${local.env}-01-svpc01"
  project = data.google_projects.project_prod_dmz.projects[0].project_id
}

data "google_compute_network" "landing-tier" {
  name    = "${local.env}-01-int-vpc01"
  project = data.google_projects.landing_zone_project.projects[0].project_id
}

data "google_compute_network" "non-internet" {
  name    = "${local.env}-02-svpc01"
  project = data.google_projects.project_non_internet.projects[0].project_id
}

module "peering-from-non-in" {
  source = "../../modules/network-peering"
  local_network = data.google_compute_network.landing-tier.self_link
  peer_network   = data.google_compute_network.non-internet.self_link
 # module_depends_on = var.peering_module_depends_on
}

module "peering-from-dmz" {
  source = "../../modules/network-peering"
  local_network = data.google_compute_network.landing-tier.self_link
  peer_network  = data.google_compute_network.prod-dmz.self_link 
 # module_depends_on = var.peering_module_depends_on
}
