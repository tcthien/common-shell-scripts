#!/bin/bash
 
docker run -d -p 20088:20088 --name=${1} --env-file=./env ${1}
