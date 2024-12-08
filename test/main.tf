module "vpc" {
  source                  = "../modules/vpc"
  network_name            = var.network_name
  auto_create_subnetworks = var.auto_create_subnetworks
  enable_ipv6_ula         = var.enable_ipv6_ula
  project_id              = var.project_id
}

module "subnets" {
  source           = "../modules/subnets"
  subnets          = var.subnets
  network_name     = module.vpc.network_name
  project_id       = var.project_id
  secondary_ranges = var.secondary_ranges
}

module "firewall" {
  source        = "../modules/firewall_rules"
  project_id    = var.project_id
  network_name  = module.vpc.network_name
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules
}

module "routes" {
  source            = "../modules/routes"
  project_id        = var.project_id
  network_name      = module.vpc.network_name
  routes            = var.routes
}
