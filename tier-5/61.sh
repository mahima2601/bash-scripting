# Which network interface on this node holds the InternalIP that Kubernetes uses for cluster communication?

ip -o addr show | grep "$(kubectl get node $(hostname) -o jsonpath='{.status.addresses[?(@.type=="InternalIP")].address}')" | awk '{print $2}'
