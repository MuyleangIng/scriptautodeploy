
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
echo "Enter 'true' or 'false' for DOCKER_DEPLOY:"
read DOCKER_DEPLOY
echo "Enter 'production', 'staging','development'for TEST_CHOICE:"
read TEST_CHOICE

# Trigger the Jenkins job with user-defined parameters
java -jar jenkins-cli.jar -auth $user:$passwd -s $url -webSocket build -v \
    -p BUILD_DOCKER=$BUILD_DOCKER \
    -p DOCKER_DEPLOY=$DOCKER_DEPLOY \
    -p TEST_CHOICE=$TEST_CHOICE \
    $jobName
