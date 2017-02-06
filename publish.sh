#!/usr/bin/env bash

set -ex

export TAG=`if [ "$TRAVIS_BRANCH" == "master" ]; then echo "latest"; else echo $TRAVIS_BRANCH ; fi`
docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASS
export CGO_ENABLED=0 
export GOOS=linux 
export GOARCH=amd64 

pushd companion

mkdir build-out
go build -o build-out/main main.go
export REPO=yifanzz/concourse-phabricator-companion
docker build -f Dockerfile -t $REPO:$COMMIT .
docker tag $REPO:$COMMIT $REPO:$TAG
docker tag $REPO:$COMMIT $REPO:travis-$TRAVIS_BUILD_NUMBER
docker push $REPO

popd

pushd resource

mkdir build-out

go build -o build-out/in in/main.go
go build -o build-out/out out/main.go
go build -o build-out/check check/main.go
export REPO=yifanzz/concourse-phabricator-resource
docker build -f Dockerfile -t $REPO:$COMMIT .
docker tag $REPO:$COMMIT $REPO:$TAG
docker tag $REPO:$COMMIT $REPO:travis-$TRAVIS_BUILD_NUMBER
docker push $REPO

popd

