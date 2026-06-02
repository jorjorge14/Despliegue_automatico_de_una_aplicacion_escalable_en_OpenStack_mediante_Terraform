resource "openstack_compute_keypair_v2" "s1_key" {
  name = "s1-key"
}
resource "openstack_compute_keypair_v2" "s2_key" {
  name = "s2-key"
}
resource "openstack_compute_keypair_v2" "s3_key" {
  name = "s3-key"
}
resource "openstack_compute_keypair_v2" "admin_key" {
  name = "admin-key"
}
resource "openstack_compute_keypair_v2" "bbdd_key" {
  name = "bbdd-key"
}
