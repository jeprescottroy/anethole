#!/bin/bash

docker-machine start default
eval "$(docker-machine env default)"

CONTAINER_NAME=$(date "+%Y-%m-%d")-mayavi-experiments

docker create -p 2222:22 -p 80:8888 -v ~/Documents/Kitematic/$CONTAINER_NAME/data/notebooks:/data/notebooks --name $CONTAINER_NAME jjpr/mayavi:latest

docker start $CONTAINER_NAME

(sleep 20; open "http://$(docker-machine ip default)") &

ssh -t -Y -p 2222 root@`docker-machine ip default` jupyter notebook --no-browser --ip=* --notebook-dir=/data


echo Done