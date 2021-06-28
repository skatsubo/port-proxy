#!/bin/bash

# display logs

DIR=$(dirname "$0")
cd "$DIR"

docker-compose logs -ft $@
