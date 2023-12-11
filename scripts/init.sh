#!/bin/bash 

docker-compose up -d coredns
COREDNS_IP=$(docker ps -f name=coredns --format '{{.ID}}')
echo "COREDNS_IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${COREDNS_IP})" > .env
