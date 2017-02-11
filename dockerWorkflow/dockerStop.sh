#!/bin/bash

docker ps -a --no-trunc | grep ${1} | awk '{print $1}' | xargs docker stop | xargs docker rm