#!/bin/bash
set -x
namespaceStatus=$(kubectl get namespaces ramcoin -o json | jq .status.phase -r)

if [ $namespaceStatus == "Active" ]
then
    echo "Namespace redTeam exists, need to clean up"
    kubectl delete namespaces redTeam
fi

echo "Creating namespace redTeam"
kubectl create namespace redTeam 
 
echo "Creating pods"
kubectl create -f ramcoin.yaml --namespace redTeam

echo "Creating services"
kubectl create -f ramcoin-service.yaml --namespace redTeam


kubectl get pods -n ramcoin

