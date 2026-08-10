#!/bin/bash


#Day 42. Parse kubectl get pods -o json with jq to list all pods that are NOT in Running state, with their namespace and reason. Concept: jq filtering. Hint: jq -r '.items[] | select(...)'.
