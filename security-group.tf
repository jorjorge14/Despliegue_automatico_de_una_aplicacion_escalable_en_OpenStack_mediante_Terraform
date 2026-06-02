resource "openstack_networking_secgroup_v2" "my_security_group" {
  name = "open"
  description = "Grupo de Seguridad para permitir todo el trafico"
  delete_default_rules = true
}
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_ingress"{
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.my_security_group.id
}
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_egress"{
  direction = "egress"
  ethertype = "IPv4"
  protocol = "tcp"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.my_security_group.id
}

# Reglas para permitir el tráfico ICMP (pruebas)
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_ingress_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.my_security_group.id
}
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_engress_1" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.my_security_group.id
}

# Reglas para permitir el tráfico ssh  (pruebas)
resource "openstack_networking_secgroup_rule_v2" "ssh_ingress" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.my_security_group.id
}