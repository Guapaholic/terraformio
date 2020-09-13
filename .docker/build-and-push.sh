#! /usr/bin/env bash

set -e

usage() {
  cat <<EOF
Builds a local docker image with the given image-name. If --registry is
specified, the build will be tagged and pushed to the given registry.

$(basename "$0") <path to dockerfile> [--terraform-version=0.13.2] [-L|--local] [--latest]

--latest            [Optional] Tag build as latest
-L,--local          [Optional] Do not push the built image to a remote repository
--terraform-version [Optional] The version of terraform to install. Defaults to 0.13.2 (latest)
-h, --help          Display this message.
EOF
}

DOCKERFILE=$1

shift

while [[ "$#" -gt 0 ]]; do case $1 in
  --terraform-version) TERRAFORM_VERSION=$2; shift;;
  --latest) TAG_LATEST=true;;
  -L|--local) LOCAL_ONLY=true;;
  -h|--help) usage; exit 0;;
  *) usage; exit 1;;
esac; shift; done

TERRAFORM_VERSION=${TERRAFORM_VERSION:-"0.13.2"}
IMAGE_NAME="pdeona/terraform-awscliv2-node"
TAG="tf-$TERRAFORM_VERSION.3"

IMAGE_WITH_TAG="$IMAGE_NAME:$TAG"

if ! docker build -t "$IMAGE_WITH_TAG" --build-arg terraform_version="$TERRAFORM_VERSION" -f "$DOCKERFILE" .; then
  echo "Docker build failed"
  exit 1
fi

if [[ -n "$LOCAL_ONLY" ]]; then
  echo "--local flag passed. Not pushing to Docker Hub."
  exit 0
fi

docker push "$IMAGE_WITH_TAG"

if [[ -z "$TAG_LATEST" ]]; then
  docker tag "$IMAGE_NAME:latest"
  docker push "$IMAGE_NAME:latest"
fi
