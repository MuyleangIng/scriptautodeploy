#!/bin/bash

# Jenkins job details
echo "Enter the Jenkins job to trigger:   frontend/deployreactv1.1.0 "
read jobName
echo "Triggering the $jobName job"

# Jenkins server authentication
user="admin"
passwd="11456d3775f4cdcdae349da61e44fac187"
url="http://188.166.191.62:8085/"

# Prompt the user for parameter values
echo "Enter 'y' for 'true' or 'n' for 'false' for BUILD_DOCKER:"
read -p "y or n: " input

if [ "$input" = "y" ]; then
    BUILD_DOCKER=true
elif [ "$input" = "n" ]; then
    BUILD_DOCKER=false
else
    echo "Invalid input. Please enter 'y' for 'true' or 'n' for 'false."
    # Handle the case where the user enters an invalid input or any other necessary action.
fi
echo "------------------------"
echo "Enter 'y' for 'true' or 'n' for 'false' for DOCKER_DEPLOY:"
read -p "y or n: " input

if [ "$input" = "y" ]; then
    DOCKER_DEPLOY=true
elif [ "$input" = "n" ]; then
    DOCKER_DEPLOY=false
else
    echo "Invalid input. Please enter 'y' for 'true' or 'n' for 'false."
    # Handle the case where the user enters an invalid input or any other necessary action.
fi
echo "------------------------"
echo "Enter 'production=master', 'staging=main','development'for branch:"
read -p "Enter 'production', 'staging': " TEST_CHOICE


echo "------------------------"
echo "Enter your registry name ex muyleangin or nexus registry"
while true; do
  read -p "Enter your registry: " REGISTRY_DOCKER
  if [ -n "$REGISTRY_DOCKER" ] ; then
    # Both inputs provided, exit the loop
    break
  else
    echo " inputs are required. Please try again."
  fi
done
echo "You entered Image Name: $REGISTRY_DOCKER"


echo "------------------------"
echo "Enter your image name ex: react or next ......"
while true; do
  read -p "Enter your images name: " BUILD_CONTAINER_NAME
  if [ -n "$BUILD_CONTAINER_NAME" ] ; then
    # Both inputs provided, exit the loop
    break
  else
    echo " inputs are required. Please try again."
  fi
done
echo "You entered Image Name: $BUILD_CONTAINER_NAME"

echo "------------------------"
echo "Docker tag ex:  1.1 or latest=default"
while true; do
  read -p "Enter docker_tag : " DOCKER_TAG
  if [ -n "$DOCKER_TAG" ] ; then
    # Both inputs provided, exit the loop
    break
  else
    echo " inputs are required. Please try again."
  fi
done
echo "You entered Image Name: $DOCKER_TAG"

echo "------------------------"
echo "Container Name for specific docker"
while true; do
  read -p "Enter container_name: " CONTAINER_NAME
  if [ -n "$CONTAINER_NAME" ] ; then
    # Both inputs provided, exit the loop
    break
  else
    echo " inputs are required. Please try again."
  fi
done
echo "You entered Image Name: $CONTAINER_NAME"

echo "------------------------"
echo "Enter REPO_URL:  ex: https://github.com/MuyleangIng/reactjs"
while true; do
  read -p "Enter your url git : " REPO_URL
  if [ -n "$REPO_URL" ] ; then
    # Both inputs provided, exit the loop
    break
  else
    echo " inputs are required. Please try again."
  fi
done
echo "You entered Image Name: $REPO_URL"


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

