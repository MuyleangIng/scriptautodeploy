#!/bin/bash

echo "Display the list of jenkins jobs"
echo "--------------------------------"

java -jar jenkins-cli.jar -auth admin:11456d3775f4cdcdae349da61e44fac187  -s http://188.166.191.62:8085/ -webSocket list-jobs
