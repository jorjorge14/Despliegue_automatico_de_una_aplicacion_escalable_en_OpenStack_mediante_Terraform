# network 1
resource "openstack_networking_network_v2" "net1" {
  name = var.network_1
}

# subnetwork 1
resource "openstack_networking_subnet_v2" "subnet1" {
  name            = var.subnet_1["subnet_name"]
  network_id      = openstack_networking_network_v2.net1.id
  cidr            = var.subnet_1["cidr"]
  ip_version      = 4
  dns_nameservers = var.dns_ip    # iportante para que el trafico a internet sea por la net1
}

# network 2
resource "openstack_networking_network_v2" "net2" {
  name = var.network_2
}

# subnetwork 1
resource "openstack_networking_subnet_v2" "subnet2" {
  name            = var.subnet_2["subnet_name"]
  network_id      = openstack_networking_network_v2.net2.id
  cidr            = var.subnet_2["cidr"]
  ip_version      = 4
}



#Creacion del puerto que conecta el Firewall con Net1
resource "openstack_networking_port_v2" "net1_port" {
  name         = "net1_port"
  network_id   = openstack_networking_network_v2.net1.id
  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.subnet1.id
    ip_address = "10.0.1.1"
  }
  depends_on = [openstack_networking_network_v2.net1, openstack_networking_subnet_v2.subnet1]
}