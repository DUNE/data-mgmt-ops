#!/bin/bash

docker stop monitoring && docker rm monitoring

detach="-d"

docker run \
        --name monitoring \
        --privileged=true \
        --link rucio-rabbitmq \
	-v /home/rucio/monitoring:/monitoring \
        -ti \
        $detach \
        rucio_base /monitoring/start.sh
