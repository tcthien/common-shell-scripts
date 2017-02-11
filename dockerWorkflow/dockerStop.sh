#!/bin/bash

if [[ "docker ps -a --no-trunc | grep ${1} | awk '{print $1}'" != "" ]]; then
	# do something
	docker ps -a --no-trunc | grep ${1} | awk '{print $1}' | xargs docker stop | xargs docker rm
else
	echo "No container to be removed."
fi
