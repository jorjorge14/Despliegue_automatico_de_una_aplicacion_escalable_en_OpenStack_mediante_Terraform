/lab/cnvr/bin/get-openstack-tutorial.sh
cd /mnt/tmp/openstack_lab-antelope_4n_classic_ovs-v04
sudo vnx -f openstack_lab.xml --create
sudo vnx -f openstack_lab.xml -x start-all,load-img
sudo vnx_config_nat ExtNet $(ip route | grep default | cut -d" " -f 5)

sudo vnx -f openstack_lab-terraform.xml --create
sudo vnx -f openstack_lab-terraform.xml -x install-terraform

cd /home/jorge.ortega/cnvr-practica-final
cp -r * /mnt/tmp/openstack_lab-antelope_4n_classic_ovs-v04/shared

#source /mnt/tmp/openstack_lab-antelope_4n_classic_ovs-v04/bin/admin-openrc.sh
#cd /mnt/tmp/openstack_lab-antelope_4n_classic_ovs-v04/shared/snapshot-bbdd
#openstack image create \            
#  --file snapshot-bbdd.raw \
#  --disk-format raw \
#  --container-format bare \
#  --public \
#  snapshot-bbdd
#openstack image list    