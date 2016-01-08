#!/bin/bash

. settings.sh

for SCALA_VERSION in ${SCALA_VERSIONS}; do
    echo "Building confluent-platform-${SCALA_VERSION}"
    cp confluent-platform/Dockerfile confluent-platform/Dockerfile.${SCALA_VERSION}
    sed -i "s/ENV SCALA_VERSION=.*/ENV SCALA_VERSION=\"${SCALA_VERSION}\"/" confluent-platform/Dockerfile.${SCALA_VERSION}
    TAGS="drmaas/platform-${SCALA_VERSION}"
    if [ "x$SCALA_VERSION" = "x$DEFAULT_SCALA_VERSION" ]; then
	TAGS="$TAGS drmaas/platform"
    fi
    for TAG in ${TAGS}; do
	docker build -t $TAG -f confluent-platform/Dockerfile.${SCALA_VERSION} confluent-platform/
    done
done

docker build -t drmaas/zookeeper zookeeper/
docker build -t drmaas/kafka kafka/
docker build -t drmaas/schema-registry schema-registry/
docker build -t drmaas/rest-proxy rest-proxy/
docker build -t drmaas/tools tools/

