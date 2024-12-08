locals {
  rules_all = [
    for rule in concat(var.ingress_rules, var.egress_rules) : merge(
      rule,
      {
        direction = contains(var.ingress_rules, rule) ? "INGRESS" : "EGRESS"
      }
    )
  ]
}


resource "google_compute_firewall" "rules" {
  for_each = { for rule in local.rules_all : rule.name => rule }

  name                    = each.value.name
  description             = each.value.description
  direction               = each.value.direction
  disabled                = lookup(each.value, "disabled", false)
  network                 = var.network_name
  project                 = var.project_id
  source_ranges           = each.value.direction == "INGRESS" ? lookup(each.value, "source_ranges", null) : null
  destination_ranges      = each.value.direction == "EGRESS" ? lookup(each.value, "destination_ranges", null) : null
  source_tags             = lookup(each.value, "source_tags", null)
  source_service_accounts = lookup(each.value, "source_service_accounts", null)
  target_tags             = lookup(each.value, "target_tags", null)
  target_service_accounts = lookup(each.value, "target_service_accounts", null)
  priority                = lookup(each.value, "priority", 1000)

  # Conditional block for log_config
  dynamic "log_config" {
    for_each = lookup(each.value, "log_config", null) != null ? [each.value.log_config] : []
    content {
      metadata = log_config.value.metadata
    }
  }

  dynamic "allow" {
    for_each = lookup(each.value, "allow", [])
    content {
      protocol = allow.value.protocol
      ports    = lookup(allow.value, "ports", null)
    }
  }

  dynamic "deny" {
    for_each = lookup(each.value, "deny", [])
    content {
      protocol = deny.value.protocol
      ports    = lookup(deny.value, "ports", null)
    }
  }
}

