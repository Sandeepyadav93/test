#!/bin/bash
set -ex
export $(echo ${1^^} | cut -d '-' -f1)_IMG=$2/$1-index:$3
cd $HOME
rm -rf install_yamls
git clone https://github.com/openstack-k8s-operators/install_yamls.git
cd $HOME/install_yamls
make crc_storage
sleep 20
make mariadb
sleep 90
make keystone
sleep 90
make mariadb_deploy SHELL=/bin/bash
sleep 90
make keystone_deploy SHELL=/bin/bash
sleep 90
