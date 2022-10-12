#!/bin/bash
COLOUR_RED='\033[1;31m'
COLOUR_END='\033[0m'
CORRECT_CRD_NAME=testthings.helmss.test

log () {
	printf "${COLOUR_RED}${1}${COLOUR_END}\n\n"
}

log "Cleaning up any previous runs..."
./cleanup.sh
log "Attempting initial install..."
kubectl create namespace helm-ss-bug > /dev/null 2>&1
helm install -n helm-ss-bug helm-ss-bug ./chart --set crd_name=invalid > /dev/null 2>&1
log "Initial install fails due to the CRD having an invalid name:"
helm history -n helm-ss-bug helm-ss-bug
log "\nNow if we correct the name and re-install..."
helm upgrade -n helm-ss-bug helm-ss-bug ./chart --set crd_name=$CORRECT_CRD_NAME > /dev/null 2>&1
log "We can see that the upgrade has succeeded and the previous failed release is marked as 'superseded':"
helm history -n helm-ss-bug helm-ss-bug

