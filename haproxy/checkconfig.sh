#!/bin/bash

# check haproxy config

DIR=$(dirname "$0")
cd "$DIR"

docker-compose exec haproxy haproxy -c -f /usr/local/etc/haproxy/haproxy.cfg
