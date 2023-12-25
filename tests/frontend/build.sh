#!/usr/bin/env bash
set -o allexport; source .env; set +o allexport
sed -i '7d' package.json
sed -i "s~--mount source=`pwd`~--mount source=${folderName}~g" ./manage.sh
./manage.sh build-frontend-bundle
rsync -avr --delete ./bundles/frontend/ ./docker/images/bundle-frontend/
rm -f ./docker/images/docker-compose.yaml
mv ./docker/images/build.sh ./docker/images/build-docker.sh
cp -rf ./docker/images/* ./
mv Dockerfile.frontend Dockerfile
docker buildx build . --output type=docker,name=elestio4test/penpot-frontend:latest | docker load