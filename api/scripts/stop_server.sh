#!/bin/bash
isAppRunning=`pgrep java`
if [[ -n  $isAppRunning ]]; then
    echo Java is Running
    sudo kill -9  $isAppRunning
fi