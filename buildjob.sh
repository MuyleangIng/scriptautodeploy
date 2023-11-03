#!/bin/bash

echo "Enter the jenkins jobs which you trigger"
read jobName
echo "trigging the $jobName job"

user=admin
passwd=11456d3775f4cdcdae349da61e44fac187
url=http://188.166.191.62:8085/
java -jar jenkins-cli.jar -auth $user:$passwd  -s $url -webSocket build $jobName
