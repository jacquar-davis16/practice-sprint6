#!/bin/bash

#java -jar /home/ubuntu/api/target/webApp.war
cd /home/ubuntu/target
nohup java -jar *.war </dev/null &>/dev/null &

sudo iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080