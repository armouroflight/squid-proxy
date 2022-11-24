#!/bin/bash

set -x

if [ -f ca/squidCA.key ]; then
   echo "Using current ca"
else
   echo "Creating CA"
   pushd ca
   ./create-ca.sh
   popd
fi

docker build . -t squid

./test.sh

# These commands can be used to get an example configuration file
# echo "Extract default configuration"
# docker run --rm squid cat /etc/squid/squid.conf.default > resources/squid.conf.default
