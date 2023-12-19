#!/usr/bin/env bash

sed -i '7d' package.json
./manage.sh build-exporter-bundle
rsync -avr --delete ./bundles/exporter/ ./docker/images/bundle-exporter/
rm -f ./docker/images/docker-compose.yaml
cp -rf ./docker/images/* ./
mv Dockerfile.exporter Dockerfile
docker buildx build . --output type=docker,name=elestio4test/penpot-exporter:latest | docker load
