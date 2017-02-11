#!/bin/bash

sudo docker images --no-trunc | grep none | awk '{print $3}' | xargs sudo docker rmi
