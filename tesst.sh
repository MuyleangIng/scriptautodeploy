#!/bin/bash

# Jenkins job details
echo "Enter the Jenkins job to trigger: "
read jobName
echo "Triggering the $jobName job"

# Jenkins server authentication
user="admin"
passwd="11456d3775f4cdcdae349da61e44fac187"
url="http://188.166.191.62:8085/"

# Prompt the user for parameter values

# Prompt the user for environment variable values
echo "Enter REGISTRY_DOCKER:"
read REGISTRY_DOCKER




# Trigger the Jenkins job with user-defined environment variables
# java -jar jenkins-cli.jar -auth $user:$passwd -s $url -webSocket build -v \
#     -p BUILD_DOCKER=$BUILD_DOCKER \
#     -p DOCKER_DEPLOY=$DOCKER_DEPLOY \
#     -p TEST_CHOICE=$TEST_CHOICE \
#     -e REGISTRY_DOCKER="$REGISTRY_DOCKER" \
#     -e BUILD_CONTAINER_NAME="$BUILD_CONTAINER_NAME" \
#     -e REPO_URL="$REPO_URL" \
#     $jobName
java -jar jenkins-cli.jar -auth $user:$passwd -s $url -webSocket build -v \
    -p REGISTRY_DOCKER="$REGISTRY_DOCKER" \
    $jobName
