#!/bin/bash

#Day 11. Write a script using a case statement that 
#takes one of start|stop|restart|status and prints
# what it would do. Anything else prints usage. 
#Concept: case. Hint: this mirrors init-script structure.

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



