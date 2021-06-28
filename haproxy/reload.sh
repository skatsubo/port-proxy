#!/bin/bash

# reload haproxy

DIR=$(dirname "$0")
cd "$DIR"

docker-compose kill -s HUP
