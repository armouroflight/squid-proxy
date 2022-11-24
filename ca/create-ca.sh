#!/bin/bash

docker build -t create-ca .

#docker run --name create-ca3 --mount type=bind,source="$(pwd)",target=/ca/ create-ca ls -alF /bin/create-ca.sh
#docker rm create-ca3
#docker run --name create-ca2 --mount type=bind,source="$(pwd)",target=/ca/ create-ca cat /bin/create-ca.sh
#docker rm create-ca2
docker run --name create-ca --mount type=bind,source="$(pwd)",target=/ca/ create-ca sh -c /bin/create-ca.sh 

#Tidy - this is just here to build the CA certs
docker rm create-ca
docker rmi create-ca
