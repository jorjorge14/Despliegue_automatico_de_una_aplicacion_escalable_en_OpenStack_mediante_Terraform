#!/bin/bash

export OS_USERNAME=admin
export OS_PROJECT_NAME=admin
export OS_PASSWORD="xxxx"
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_AUTH_URL=http://controller:5000/v3
export OS_REGION_NAME=RegionOne
export OS_INTERFACE=public
export OS_IDENTITY_API_VERSION=3

# Borrar VMs
openstack server delete s1 s2 s3 admin bbdd

# Borrar Key Pairs
openstack keypair delete s1-key s2-key s3-key admin-key bbdd-key

# Borrar Floating IPs
openstack floating ip delete $(openstack floating ip list -f value -c "Floating IP Address")

# Quitar subnets del router
openstack router remove subnet router-fw Subnet1
openstack router remove subnet router-fw Subnet2

# Borrar Load Balancer (no funciona)
#openstack loadbalancer delete lb-web

# Borrar Router
openstack router delete router-fw

# Borrar puertos de Net1 y Net2
for port in $(openstack port list -f value -c ID --network Net1); do
    openstack port delete $port
done

for port in $(openstack port list -f value -c ID --network Net2); do
    openstack port delete $port
done

# Borrar Subnets
openstack subnet delete Subnet1 Subnet2

# Borrar Networks
openstack network delete Net1 Net2

# Borrar Security-group
openstack security group delete open
