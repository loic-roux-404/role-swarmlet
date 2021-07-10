#!/usr/bin/env bash
#
# Custom coolify installer
#
{{ 'Located in %s' % coolify_data_volume | comment }}
#
#################
source .env

buildCoolify() {
    docker build --name {{ coolify_data_volume }} --label coolify-reserve=true \
        -v /var/run/docker.sock:/var/run/docker.sock -v {{ coolify_data_volume }}:{{ coolify_data_volume }} \
        -t coolify -f install/Dockerfile-new .
}

parseEnvAndDeploy() {
    set -a && source .env && set +a && envsubst < install/coolify-template.yml | docker stack deploy -c - coollabs-coolify
}

preTasks() {
echo '
##############################
#### Pulling Git Updates #####
##############################'
GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" git pull

if [ $? -ne 0 ]; then
    echo '
####################################
#### Ooops something not okay! #####
####################################'
    exit 1
fi

echo '
##############################
#### Building Base Image #####
##############################'
buildCoolify

if [ $? -ne 0 ]; then
    echo '
####################################
#### Ooops something not okay! #####
####################################'
    exit 1
fi
}

docker network create ${DOCKER_NETWORK} --driver overlay

case "$1" in
    "all")
       preTasks
       echo '
#################################
#### Rebuilding everything. #####
#################################'
        buildCoolify
        docker stack rm coollabs-coolify
        parseEnvAndDeploy
    ;;
    "coolify")
       preTasks
       echo '
##############################
#### Rebuilding Coolify. #####
##############################'
        buildCoolify
        docker service rm coollabs-coolify_coolify
        parseEnvAndDeploy
    ;;
    "proxy")
       preTasks
       echo '
############################
#### Rebuilding Proxy. #####
############################'
        buildCoolify
        docker service rm coollabs-coolify_proxy
        parseEnvAndDeploy
    ;;
    "upgrade-phase-1")
        preTasks
        echo '
################################
#### Upgrading Coolify P1. #####
################################'
        buildCoolify
    ;;
    "upgrade-phase-2")
        echo '
################################
#### Upgrading Coolify P2. #####
################################'
        docker service rm coollabs-coolify_coolify
        parseEnvAndDeploy
    ;;
    *)
        exit 1
     ;;
esac
