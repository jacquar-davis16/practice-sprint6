#!/bin/bash
isAppRunning=`pgrep java`
if [[ -n  $isAppRunning ]]; then
    echo Java is Running > tmp.txt
    sudo kill -9  $isAppRunning
fi