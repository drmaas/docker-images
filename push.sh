#!/bin/bash

. settings.sh

for SCALA_VERSION in ${SCALA_VERSIONS}; do
    docker push drmaas/platform-${SCALA_VERSION}
done
docker push drmaas/platform

docker push drmaas/zookeeper
docker push drmaas/kafka
docker push drmaas/schema-registry
docker push drmaas/rest-proxy
docker push drmaas/tools
