#!/usr/bin/env bash
set -o allexport; source .env; set +o allexport
sed -i '7d' package.json
sed -i 's/export CURRENT_USER_ID=$(id -u);/export CURRENT_USER_ID=$(id -u node);/' ./manage.sh
sed -i 's/--mount source=`pwd`/--mount source=${folderName}/' ./manage.sh
sed -i 's~$DEVENV_IMGNAME:latest sudo -EH -u penpot ./scripts/build $version~$DEVENV_IMGNAME:latest sudo -EH -u penpot sudo ./scripts/build $version~' ./manage.sh
./manage.sh build-backend-bundle
rsync -avr --delete ./bundles/backend/ ./docker/images/bundle-backend/
rm -f ./docker/images/docker-compose.yaml
mv ./docker/images/build.sh ./docker/images/build-docker.sh
cp -rf ./docker/images/* ./
mv Dockerfile.backend Dockerfile
docker buildx build . --output type=docker,name=elestio4test/penpot-backend:latest | docker load