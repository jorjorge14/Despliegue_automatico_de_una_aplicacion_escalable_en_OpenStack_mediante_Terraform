resource "openstack_networking_floatingip_v2" "admin_floating_ip" {
  pool = var.external_network_name
}

resource "openstack_compute_floatingip_associate_v2" "admin_floating_ip_assoc" {
  floating_ip = openstack_networking_floatingip_v2.admin_floating_ip.address
  instance_id = openstack_compute_instance_v2.admin.id
}
