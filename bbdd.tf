module "bbdd" {
  source          = "./modules/bbdd"
  name            = "bbdd"
  flavor          = "m1.smaller"
  image           = "snapshot-bbdd"  # snapshot para crear la base de datos 
  key_pair        = openstack_compute_keypair_v2.bbdd_key.name
  depends_on = [ openstack_networking_subnet_v2.subnet1, openstack_networking_subnet_v2.subnet2]
  security_groups = ["open"]
  network_name      = openstack_networking_network_v2.net2.id       
  user_data       = file("cloud-init/cloud-init-bbdd.yaml")
}

