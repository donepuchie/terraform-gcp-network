locals {
  routes = {
    for route in var.routes :
    lookup(route, "name", "${var.network_name}-route-${uuid()}") => route
  }
}

resource "google_compute_route" "routes" {
  for_each = local.routes

  project = var.project_id
  network = var.network_name

  name                   = each.key
  description            = lookup(each.value, "description", null)
  tags                   = compact(split(",", tostring(lookup(each.value, "tags", ""))))
  dest_range             = lookup(each.value, "destination_range", null) != null ? lookup(each.value, "destination_range", null) : (var.delete_default_internet_route ? "0.0.0.0/0" : null)
  next_hop_gateway       = lookup(each.value, "next_hop_internet", "false") == "true" ? "default-internet-gateway" : null
  next_hop_ip            = lookup(each.value, "next_hop_ip", null)
  next_hop_instance      = lookup(each.value, "next_hop_instance", null)
  next_hop_instance_zone = lookup(each.value, "next_hop_instance_zone", null)
  next_hop_vpn_tunnel    = lookup(each.value, "next_hop_vpn_tunnel", null)
  next_hop_ilb           = lookup(each.value, "next_hop_ilb", null)
  priority               = lookup(each.value, "priority", null)
  
}