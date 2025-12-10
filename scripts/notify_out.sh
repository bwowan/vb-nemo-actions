#!/bin/bash

if [ $1 -eq 0 ]
then 
  param="-u normal -t 6000 \"OK:\""
else
  param="-u critical -t 50000 \"FAIL:\""
fi

notify-send --app-name=nemo --icon=extract-archive --wait $param  "$2"


