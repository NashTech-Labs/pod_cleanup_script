# Cleanup Old Pods

This script is designed to automate the cleanup of old Kubernetes pods that have completed their tasks or failed. It targets pods in the `Succeeded` and `Failed` phases that are older than 30 days. This helps to free up resources and maintain a tidy Kubernetes environment.

## Overview

The `pod_cleanup.sh` script is intended to be used in a Kubernetes environment to automatically remove pods that have completed their execution and are no longer needed. This helps in keeping the cluster clean and free of unnecessary resources.


## Prerequisites
-- **Kubernetes CLI (kubectl)**: Ensure you have kubectl installed and configured to access your Kubernetes cluster.
-- **jq**: The script uses jq to parse JSON. Make sure jq is installed on your system.


## How It Works

1. **Namespace Definition**: The script targets the `default` namespace. You can modify the `NAMESPACE` variable in the script to target a different namespace.
2. **Date Calculation**: The script calculates the cutoff date to determine which pods are older than 30 days.
3. **Pod Selection**: It retrieves all pods in the specified namespace that are in the `Succeeded` phase.
4. **Pod Deletion**: Pods older than 30 days are selected and deleted.
