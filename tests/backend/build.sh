#!/usr/bin/env bash

sed -i '7d' package.json
./manage.sh build-backend-bundle
rsync -avr --delete ./bundles/backend/ ./docker/images/bundle-backend/
rm -f ./docker/images/docker-compose.yaml
cp -rf ./docker/images/* ./
mv Dockerfile.backend Dockerfile
docker buildx build . --output type=docker,name=elestio4test/penpot-backend:latest | docker load
