#!/bin/bash
set -ex
eval $(crc oc-env)
oc login -u kubeadmin -p 12345678 https://api.crc.testing:6443
cd $HOME/keystone-operator
OS_REGISTRY=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')
#workaround to avoid "Error: error creating build container: short-name resolution enforced but cannot prompt without a TTY"
podman pull docker.io/library/golang:1.18
IMAGE_TAG_BASE=${OS_REGISTRY}/$(oc project -q)/keystone-operator VERSION=0.0.1 IMG=$IMAGE_TAG_BASE:v$VERSION make manifests build docker-build docker-push bundle bundle-build bundle-push catalog-build catalog-push
oc set image-lookup --all
