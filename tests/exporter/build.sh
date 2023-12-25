#!/usr/bin/env bash
set -o allexport; source .env; set +o allexport
sed -i '7d' package.json
sed -i "s~--mount source=`pwd`~--mount source=${folderName}~g" ./manage.sh
./manage.sh build-exporter-bundle
rsync -avr --delete ./bundles/exporter/ ./docker/images/bundle-exporter/
rm -f ./docker/images/docker-compose.yaml
mv ./docker/images/build.sh ./docker/images/build-docker.sh
cp -rf ./docker/images/* ./
mv Dockerfile.exporter Dockerfile
docker buildx build . --output type=docker,name=elestio4test/penpot-exporter:latest | docker load
