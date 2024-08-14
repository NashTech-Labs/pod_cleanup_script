 #!/bin/bash

    # Define the namespace
    NAMESPACE="default"

    # Get the cutoff date (30 days ago) in epoch seconds
    CUTOFF_DATE=$(date -d '30 days ago' +%s)

    # Function to delete old pods based on phase
    delete_old_pods() {
      local PHASE=$1
      echo "Processing pods with phase: $PHASE"

      # Get the list of all pods in the specified phase
      PODS=$(kubectl get pods --field-selector status.phase=$PHASE -n $NAMESPACE --ignore-not-found=true -o json)

      # Check if there are any pods older than 30 days
      OLD_PODS=$(echo "$PODS" | jq -r \
        '.items[] |
         select(.status.startTime != null) |
         select((.status.startTime | fromdateiso8601) < '"$CUTOFF_DATE"') |
         .metadata.name')

      if [ -z "$OLD_PODS" ]; then
        echo "No $PHASE pods older than 30 days. No action taken."
        return
      fi

      # Delete pods older than 30 days
      for POD_NAME in $OLD_PODS; do
        echo "Deleting $PHASE pod $POD_NAME"
        kubectl delete pod $POD_NAME -n $NAMESPACE
      done
    }

    # Clean up succeeded and failed pods
    delete_old_pods "Succeeded"
    delete_old_pods "Failed"