#!/bin/sh
set -Eeuo pipefail

apk update
apk add wget

elastic_app="kibana"
# renovate: datasource=github-releases depName=elastic/elasticsearch
elastic_version="8.11.2"

echo hi
