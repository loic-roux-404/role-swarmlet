#!/bin/bash -e

STACK=$1
SECRET_NAME=$2
DATA=$3

if [ -z ${STACK+x} ] || [ -z ${SECRET_NAME+x} ] || [ -z ${DATA+x} ] &&\
    echo "Missing var in [STACK, SECRET_NAME, DATA], Actual: $@" exit 1 || true

echo $DATA | docker secret create env.2 -

docker service update --detach=false --secret-rm $SECRET_NAME --secret-add source=$SECRET_NAME.2,target=$SECRET_NAME $STACK

docker secret rm env

echo $DATA | docker secret create env -

docker service update --detach=false --secret-rm $SECRET_NAME.2 --secret-add source=$SECRET_NAME,target=$SECRET_NAME $STACK

docker secret rm env.2
