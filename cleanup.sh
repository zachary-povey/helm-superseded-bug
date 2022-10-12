#!/bin/bash
set -e
helm uninstall -n helm-ss-bug helm-ss-bug
kubectl delete namespace helm-ss-bug