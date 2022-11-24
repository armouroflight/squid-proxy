#!/bin/bash

set -x
docker build . -t squid

./test.sh
