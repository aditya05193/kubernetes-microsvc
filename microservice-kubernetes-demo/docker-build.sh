#!/bin/sh
if [ -z "$DOCKER_ACCOUNT" ]; then
    DOCKER_ACCOUNT=aditya05193
fi;
docker build --tag=$DOCKER_ACCOUNT/microservice-kubernetes-demo-catalog:v1 microservice-kubernetes-demo-catalog
docker push $DOCKER_ACCOUNT/microservice-kubernetes-demo-catalog

docker build --tag=$DOCKER_ACCOUNT/microservice-kubernetes-demo-customer:v1 microservice-kubernetes-demo-customer
docker push $DOCKER_ACCOUNT/microservice-kubernetes-demo-customer

docker build --tag=$DOCKER_ACCOUNT/microservice-kubernetes-demo-order:v1 microservice-kubernetes-demo-order
docker push $DOCKER_ACCOUNT/microservice-kubernetes-demo-order
