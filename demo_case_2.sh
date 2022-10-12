#!/bin/bash
COLOUR_RED='\033[1;31m'
COLOUR_END='\033[0m'
VALID_CRD_NAME=testthings.helmss.test
INVALID_CRD_NAME=invalid

log () {
	printf "${COLOUR_RED}${1}${COLOUR_END}\n\n"
}
log "Cleaning up any previous runs..."
./cleanup.sh
log "Attempting initial install..."
kubectl create namespace helm-ss-bug > /dev/null 2>&1
helm install -n helm-ss-bug helm-ss-bug ./chart --set crd_name=$VALID_CRD_NAME > /dev/null 2>&1
log "Initial install succeeds:"
helm history -n helm-ss-bug helm-ss-bug
log "\nNow if we break the name and upgrade..."
helm upgrade -n helm-ss-bug helm-ss-bug ./chart --set crd_name=$INVALID_CRD_NAME > /dev/null 2>&1
log "We can see that the upgrade failed:"
helm history -n helm-ss-bug helm-ss-bug
log "\nIf we then try to rollback to our last good release..."
helm rollback -n helm-ss-bug helm-ss-bug 1 > /dev/null 2>&1
log "It fails (see linked issue in readme) but also, it marks the failed release as superseded:"
helm history -n helm-ss-bug helm-ss-bug

