#!/bin/bash

#Day 12. Write a script that checks whether a service 
#(e.g. nginx) is active, using systemctl, and prints 
#a clear up/down message. Concept: exit codes from real commands.Hint: systemctl is-active --quiet nginx.

# systemctl status nginx


if systemctl is-active nginx &>/dev/null; then
    echo "service is up"
else
    echo "service is down"

fi



