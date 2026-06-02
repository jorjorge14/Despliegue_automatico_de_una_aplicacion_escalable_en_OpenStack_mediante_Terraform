resource "openstack_networking_floatingip_v2" "lb_floating_ip" {
  pool = var.external_network_name
}

resource "openstack_networking_floatingip_associate_v2" "lb_floating_ip_assoc" {
  floating_ip = openstack_networking_floatingip_v2.lb_floating_ip.address
  port_id     = openstack_lb_loadbalancer_v2.lb.vip_port_id
}
