#!/bin/bash
docker container prune -f
VERSION=$(docker run --name test-squid -it squid squid -v)


check_flag() {
	FLAG=$1
        echo -n "Checking $FLAG ... "
	if echo $VERSION | grep "${FLAG}" > /dev/null; then
  		echo "Has flag $FLAG"
        else
                echo "Missing flag $FLAG"
		exit 1
	fi
}

check_flag "\-\-enable-ssl-crtd"
check_flag "\-\-enable-openssl"

