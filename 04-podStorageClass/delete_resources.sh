#!/bin/bash

echo "Deleting all resources!!"

kubectl config set-context --current --namespace=default

kubectl delete sts --all
kubectl delete pvc --all
kubectl delete pv --all
kubectl delete sc --all
kubectl delete po busybox

echo "Resources Deleted Successfully!!"
