#!/bin/bash
eval $(crc oc-env)
oc login -u kubeadmin -p 12345678 https://api.crc.testing:6443
cd $HOME/install_yamls
echo "make crc_storage" &>> $HOME/install_operator.log
make crc_storage
echo "make mariadb" &>> $HOME/install_operator.log
make mariadb
sleep 30 
echo "make keystone" &>> $HOME/install_operator.log
make keystone
sleep 30
echo "make mariadb_deploy" &>> $HOME/install_operator.log
make mariadb_deploy
sleep 60
echo "make keystone_deploy" &>> $HOME/install_operator.log
make keystone_deploy
sleep 90
