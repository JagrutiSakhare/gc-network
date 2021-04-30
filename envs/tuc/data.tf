data "google_active_folder" "env" {
  display_name = "fldr-${local.env}"
  parent       = local.parent_id
}

data "google_projects" "landing_zone_project" {
  filter = "parent.id:${split("/", data.google_active_folder.env.name)[1]} labels.application_name=landing_zone labels.environment=${local.env} lifecycleState=ACTIVE"
}