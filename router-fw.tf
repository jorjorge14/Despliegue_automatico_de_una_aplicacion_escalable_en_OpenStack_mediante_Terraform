data "openstack_networking_network_v2" "external_network" {
  name = var.external_network_name
}

#Añade el router-firewall a la red externa
resource "openstack_networking_router_v2" "router-fw" {
  name = "router-fw"
  external_network_id = data.openstack_networking_network_v2.external_network.id
}
#Asignar el router-firewall a la subnet1
resource "openstack_networking_router_interface_v2" "routerfw_if_net1" {
  router_id = openstack_networking_router_v2.router-fw.id
  port_id   = openstack_networking_port_v2.net1_port.id
}


# Reglas de firewall 
resource "openstack_fw_rule_v2" "ssh_admin" {
  name                = "ssh_admin"
  action              = "allow"
  protocol            = "tcp"
  destination_port    = "2025"
  source_ip_address = var.ip_default
  destination_ip_address = openstack_compute_instance_v2.admin.network[0].fixed_ip_v4
  depends_on = [ openstack_compute_instance_v2.admin ]
}

resource "openstack_fw_rule_v2" "http_lb" {
  name                = "http_lb"
  action              = "allow"
  protocol            = "tcp"
  destination_port    = "80"
  source_ip_address = var.ip_default
  destination_ip_address = openstack_lb_loadbalancer_v2.lb.vip_address
  depends_on = [ openstack_lb_loadbalancer_v2.lb ]
}

resource "openstack_fw_rule_v2" "internal" {
  name                = "internal"
  action              = "allow"
  protocol            = "any"
  source_ip_address   = var.subnet_1["cidr"]
  depends_on = [ openstack_networking_subnet_v2.subnet1 ]
}

# Políticas
resource "openstack_fw_policy_v2" "in_policy" {
  name           = "in_policy"
  rules = [ openstack_fw_rule_v2.internal.id, openstack_fw_rule_v2.http_lb.id, openstack_fw_rule_v2.ssh_admin.id]
  depends_on = [ openstack_fw_rule_v2.internal, openstack_fw_rule_v2.http_lb, openstack_fw_rule_v2.ssh_admin]
}

resource "openstack_fw_policy_v2" "out_policy" {
  name           = "out_policy"
  rules = [openstack_fw_rule_v2.internal.id]
  depends_on = [ openstack_fw_rule_v2.internal]
}

# Grupo de firewall 
resource "openstack_fw_group_v2" "fw_group" {
  name                       = "fw_group"
  ingress_firewall_policy_id = openstack_fw_policy_v2.in_policy.id
  egress_firewall_policy_id  = openstack_fw_policy_v2.out_policy.id
  ports = [ openstack_networking_port_v2.net1_port.id]
  depends_on = [ openstack_fw_policy_v2.in_policy, openstack_fw_policy_v2.out_policy, openstack_networking_port_v2.net1_port]
}
