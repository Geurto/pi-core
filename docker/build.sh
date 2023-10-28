#!/bin/bash

# get ARCH from input argument
ARCH=$1
if [ -z "$ARCH" ]; then
    echo "No architecture specified"
    exit 1
fi

if [ "$ARCH" == "amd64" ]; then
    PLATFORM="linux/amd64"
    BASE_IMAGE="ubuntu:jammy"
elif [ "$ARCH" == "arm64" ]; then
    PLATFORM="linux/arm64/v8"
    BASE_IMAGE="arm64v8/ubuntu:jammy"
else
    echo "Unknown architecture: $ARCH"
    exit 1
fi

# run github_token.sh to get token in environment
source ./github_token.sh
export DOCKER_BUILDKIT=1

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
(cd "$SCRIPT_DIR"/../ && \
docker build \
--build-arg BASE_IMAGE=$BASE_IMAGE \
--build-arg GITHUB_TOKEN=GITHUB_TOKEN \
-f ./docker/Dockerfile \
--platform $PLATFORM \
-t "big-juice/pi:core-$ARCH" \
./src )
