#!/bin/bash

if [[ $# -lt 2 ]]; then
    echo "$0 <output path>"
    exit 1
fi

OUTPUT_PATH=$1
INPUT_PATH=$2
IMAGE_ID=$(docker build -q .)

docker run --rm \
    --privileged \
    -v $OUTPUT_PATH:/home/output \
    -v $INPUT_PATH:/home/input \
    -it $IMAGE_ID
