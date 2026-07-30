#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Usage: $0 <exit-code> [message]" >&2
  exit 2
fi

if [ "$1" -eq 0 ]; then
  urgency="normal"
  timeout="6000"
  summary="OK:"
else
  urgency="critical"
  timeout="50000"
  summary="FAIL:"
fi

notify-send --app-name=nemo --icon=extract-archive \
  -u "$urgency" -t "$timeout" "$summary" "${2:-}"
