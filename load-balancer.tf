resource "openstack_lb_loadbalancer_v2" "lb" {
  name          = "lb-web"
  vip_subnet_id = openstack_networking_subnet_v2.subnet1.id
  depends_on = [openstack_compute_instance_v2.web3]
}

resource "openstack_lb_listener_v2" "lb" {
  name           = "listener-web"
  protocol       = "HTTP"
  protocol_port  = 80
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb.id
  depends_on = [ openstack_lb_loadbalancer_v2.lb ]
}

resource "openstack_lb_pool_v2" "lb" {
  name        = "pool-web"
  protocol    = "HTTP"
  lb_method = "ROUND_ROBIN"
  listener_id = openstack_lb_listener_v2.lb.id
  depends_on = [ openstack_lb_listener_v2.lb ]
}

resource "openstack_lb_member_v2" "lb1" {
  pool_id = openstack_lb_pool_v2.lb.id
  address = openstack_compute_instance_v2.web1.network[0].fixed_ip_v4
  protocol_port = 80
  subnet_id = openstack_networking_subnet_v2.subnet1.id
  depends_on = [openstack_lb_pool_v2.lb]
}

resource "openstack_lb_member_v2" "lb2" {
  pool_id = openstack_lb_pool_v2.lb.id
  address = openstack_compute_instance_v2.web2.network[0].fixed_ip_v4
  protocol_port = 80
  subnet_id = openstack_networking_subnet_v2.subnet1.id
  depends_on = [openstack_lb_pool_v2.lb]
}

resource "openstack_lb_member_v2" "lb3" {
  pool_id = openstack_lb_pool_v2.lb.id
  address = openstack_compute_instance_v2.web3.network[0].fixed_ip_v4
  protocol_port = 80
  subnet_id = openstack_networking_subnet_v2.subnet1.id
  depends_on = [openstack_lb_pool_v2.lb]
}




