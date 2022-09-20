#!/bin/bash

#java -jar /home/ubuntu/api/target/webApp.war
cd /home/ubuntu/target
nohup java -jar *.war </dev/null &>/dev/null &
