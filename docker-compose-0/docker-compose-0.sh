#!/usr/bin/env bash
set -ex

docker network create -d bridge --subnet 172.16.0.0/16 --gateway 172.16.0.1 monet_network
docker compose -f /opt/docker/docker-compose-0.yml up -d
