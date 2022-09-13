#!/bin/bash
set -ex
eval $(crc oc-env)
oc login -u kubeadmin -p 12345678 https://api.crc.testing:6443
export $(echo ${1^^} | cut -d '-' -f1)_IMG=$2/$1:$3

cd $HOME/install_yamls
make mariadb
sleep 30
make keystone
sleep 30
make mariadb_deploy
sleep 60
make keystone_deploy
sleep 90
