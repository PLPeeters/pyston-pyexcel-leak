#!/bin/bash

set -e

docker build -t pyston-leak-demo .
docker run --platform linux/amd64 -e JIT_MIN_RUNS=99999999999 -it pyston-leak-demo
