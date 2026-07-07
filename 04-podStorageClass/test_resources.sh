#!/bin/bash

kubectl apply -f sc.yml
kubectl apply -f pv.yml
kubectl apply -f sts-headless-svc.yml

# kubectl scale sts pizza-ordering-sys --replicas=4

kubectl run busybox --image=busybox \
--restart=Never \
-- /bin/sh -c 'while true; do nslookup pizza-ordering-sys-0.pizza-ordering-sys-headless-svc.default.svc.cluster.local; sleep 5; done;'

while true;
  do
    export CURENT_STS_POD_STATUS=$(kubectl get po pizza-ordering-sys-0 -o jsonpath='{.status.phase}')
    echo "CURENT_STS_POD_STATUS: ${CURENT_STS_POD_STATUS}"

    if [[ $CURENT_STS_POD_STATUS == "Running" ]]; then
      echo "Checking STS DNS is working or not..."
      kubectl logs -f busybox
    else 
      echo "Waiting for 5 seconds & try again!!"
      sleep 5
    fi
  done

