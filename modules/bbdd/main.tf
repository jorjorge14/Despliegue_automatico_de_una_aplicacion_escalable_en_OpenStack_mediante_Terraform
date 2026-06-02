terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
}

resource "openstack_compute_instance_v2" "bbdd" {
  name            = var.name
  flavor_name     = var.flavor
  image_name      = var.image   
  key_pair        = var.key_pair
  security_groups = var.security_groups

  network {
    uuid = var.network_name
  }
  user_data = var.user_data
}
