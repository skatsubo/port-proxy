#!/bin/bash

# recreate service with docker-compose

DIR=$(dirname "$0")
cd "$DIR"

docker-compose stop ; docker-compose rm -vf ; docker-compose up -d
