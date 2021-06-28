#!/bin/sh

LOCAL_PORT=13306
# ping ensembldb.ensembl.org
# PING hl-ensembl-databases.ebi.ac.uk (193.62.192.245)
TARGET_HOST=193.62.192.245
TARGET_PORT=3306

docker run -d --rm --name socat -p $LOCAL_PORT:$LOCAL_PORT alpine/socat -d tcp-listen:$LOCAL_PORT,fork,reuseaddr tcp-connect:$TARGET_HOST:$TARGET_PORT
