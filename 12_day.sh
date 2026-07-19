#!/bin/bash

#Day 12. Write a script that checks whether a service 
#(e.g. nginx) is active, using systemctl, and prints 
#a clear up/down message. Concept: exit codes from real commands.Hint: systemctl is-active --quiet nginx.

case "$1" in 
    start)
        echo "starting the service..."
        ;;
    stop)
        echo "stopping the service..."
        ;;
    restart)
        echo "restarting the service..."
        ;;
    status)
        echo "showing service status..."
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status}" >&2
        exit 1
        ;;
    esac



