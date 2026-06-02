#web server 1
resource "openstack_compute_instance_v2" "web1" {
  name            = "s1"
  image_name      = "focal-server-cloudimg-amd64-vnx"
  flavor_name     = "m1.smaller"
  security_groups = ["open"]
  key_pair       = openstack_compute_keypair_v2.s1_key.name
  depends_on = [ openstack_networking_subnet_v2.subnet1, openstack_networking_subnet_v2.subnet2]
  network {
    name = var.network_1
  }
  network {
    name = var.network_2
  }
  user_data = file("cloud-init/cloud-init-web.yaml")
}

#web server 2
resource "openstack_compute_instance_v2" "web2" {
  name            = "s2"
  image_name      = "focal-server-cloudimg-amd64-vnx"
  flavor_name     = "m1.smaller"
  security_groups = ["open"]
  key_pair       = openstack_compute_keypair_v2.s2_key.name
  depends_on = [ openstack_networking_subnet_v2.subnet1, openstack_networking_subnet_v2.subnet2]
  network {
    name = var.network_1
  }
  network {
    name = var.network_2
  }
  user_data = file("cloud-init/cloud-init-web.yaml")
}

#web server 3
resource "openstack_compute_instance_v2" "web3" {
  name            = "s3"
  image_name      = "focal-server-cloudimg-amd64-vnx"
  flavor_name     = "m1.smaller"
  security_groups = ["open"]
  key_pair       = openstack_compute_keypair_v2.s3_key.name
  depends_on = [ openstack_networking_subnet_v2.subnet1, openstack_networking_subnet_v2.subnet2]
  network {
    name = var.network_1
  }
  network {
    name = var.network_2
  }
  user_data = file("cloud-init/cloud-init-web.yaml")
}

#admin
resource "openstack_compute_instance_v2" "admin" {
  name            = "admin"
  image_name      = "focal-server-cloudimg-amd64-vnx"
  flavor_name     = "m1.smaller"
  security_groups = ["open"]
  key_pair       = openstack_compute_keypair_v2.admin_key.name
  depends_on = [ openstack_networking_subnet_v2.subnet1, openstack_networking_subnet_v2.subnet2]
  network {
    name = var.network_1
  }
  network {
    name = var.network_2
  }
  user_data = file("cloud-init/cloud-init-admin.yaml")
}