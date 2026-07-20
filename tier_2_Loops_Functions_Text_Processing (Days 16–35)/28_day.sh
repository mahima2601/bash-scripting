#!/bin/bash

# Day 28. Loop over all running Kubernetes namespaces 
#(kubectl get ns) and print the pod count in each. 
#Concept: looping over command output, parsing. Hint: careful with the header row.

#!/bin/bash

for ns in $(kubectl get ns --no-headers | awk '{print $1}'); do
    count=$(kubectl get pods -n "$ns" --no-headers 2>/dev/null | wc -l)
    echo "$ns: $count pods"
done
