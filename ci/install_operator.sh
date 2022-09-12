#!/bin/bash
set -ex
eval $(crc oc-env)
oc login -u kubeadmin -p 12345678 https://api.crc.testing:6443
OS_REGISTRY=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')
oc registry login --skip-check ${OS_REGISTRY}
oc get is
oc set image-lookup --all
cd $HOME/install_yamls
echo "make mariadb"
make mariadb
sleep 30
echo "make keystone"
#make keystone
make keystone KEYSTONE_IMG=default-route-openshift-image-registry.apps-crc.testing/openstack/keystone-operator-index:v0.0.1
sleep 30
echo "make mariadb_deploy"
make mariadb_deploy
sleep 60
echo "make keystone_deploy"
make keystone_deploy
sleep 90
