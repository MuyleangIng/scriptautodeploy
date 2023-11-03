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
echo "Enter 'true' or 'false' for BUILD_DOCKER:"
read BUILD_DOCKER
echo "------------------------"
echo "Enter 'true' or 'false' for DOCKER_DEPLOY:"
read DOCKER_DEPLOY
echo "------------------------"
echo "Enter 'production', 'staging','development'for TEST_CHOICE:"
read TEST_CHOICE

# Prompt the user for environment variable values
echo "Enter REGISTRY_DOCKER:"
read REGISTRY_DOCKER
echo "------------------------"
echo "Enter BUILD_CONTAINER_NAME:"
read BUILD_CONTAINER_NAME

echo "------------------------"
echo "Enter DOCKER_TAG:"
read DOCKER_TAG

echo "------------------------"
echo "Container Name:"
read CONTAINER_NAME

echo "------------------------"
echo "Enter REPO_URL:"
read REPO_URL




# Trigger the Jenkins job with user-defined environment variables

java -jar jenkins-cli.jar -auth $user:$passwd -s $url -webSocket build -v \
    -p BUILD_DOCKER=$BUILD_DOCKER \
    -p DOCKER_DEPLOY=$DOCKER_DEPLOY \
    -p TEST_CHOICE=$TEST_CHOICE \
    -p REGISTRY_DOCKER="$REGISTRY_DOCKER" \
    -p BUILD_CONTAINER_NAME="$BUILD_CONTAINER_NAME" \
    -p CONTAINER_NAME="$CONTAINER_NAME" \
    -p DOCKER_TAG="$DOCKER_TAG"\
    -p REPO_URL="$REPO_URL" \
    $jobName