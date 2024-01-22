#!/bin/sh
STACK_NAME="seleniumgridaws"
SECONDS=0

echo "Starting to create AWS CloudFormation Stack: ${STACK_NAME}"

# Create stack
aws cloudformation create-stack \
    --template-body file://cloudformation-selenium-grid.yml \
    --stack-name $STACK_NAME \
    --capabilities CAPABILITY_NAMED_IAM

echo "Waiting for [$STACK_NAME] stack creation..."

# Wait for stack creation completion
aws cloudformation wait stack-create-complete \
    --stack-name $STACK_NAME \
    --output text

echo "Stack creation complete."

# Retrieve the unique part of the stack ID
STACK_ID_FRAGMENT=$(aws cloudformation describe-stacks \
    --stack-name $STACK_NAME \
    --query "Stacks[0].StackId" \
    --output text | cut -d '/' -f3)

# Construct the parameter name
PARAMETER_NAME="SeleniumHubPublicIP-$STACK_ID_FRAGMENT"

echo "Waiting for IP assignment to Spot Fleet instance..."

# Initialize timeout counter for IP assignment (600 seconds)
IP_ASSIGNMENT_TIMEOUT=600
IP_COUNTER=0

# Loop until the parameter exists, has a value, or timeout is reached
while [ $IP_COUNTER -lt $IP_ASSIGNMENT_TIMEOUT ]; do
    IP=$(aws ssm get-parameter --name "$PARAMETER_NAME" --query "Parameter.Value" --output text 2>/dev/null)
    if [ -n "$IP" ] && [ "$IP" != "None" ]; then
        echo "IP assigned to Spot Fleet instance: $IP"
        break
    fi

    echo "Waiting for IP assignment..."
    sleep 30 # Wait for 30 seconds before retrying
    IP_COUNTER=$((IP_COUNTER + 30))
done

# Check if the loop exited due to timeout
if [ $IP_COUNTER -ge $IP_ASSIGNMENT_TIMEOUT ]; then
    echo "Timeout reached. IP assignment not confirmed."
    exit 1
fi

echo "Access Selenium Hub status at: http://$IP:4444/status"

# Check if the Selenium Hub status is ready
STATUS_CHECK_TIMEOUT=120
STATUS_COUNTER=0
HUB_READY=false

# Loop until the hub reports it is ready or timeout is reached
while [ $STATUS_COUNTER -lt $STATUS_CHECK_TIMEOUT ]; do
    # Fetch status from Selenium Hub
    HUB_STATUS=$(curl -s "http://$IP:4444/status" | jq -r '.value.ready' 2>/dev/null)

    # Check if the response contains "ready": true
    if [ "$HUB_STATUS" = "true" ]; then
        echo "Selenium Hub is ready."
        HUB_READY=true
        break
    else
        echo "Waiting for Selenium Hub to be ready..."
        sleep 10 # Wait for 10 seconds before retrying
        STATUS_COUNTER=$((STATUS_COUNTER + 10))
    fi
done

# Check if the loop exited due to timeout
if [ "$HUB_READY" = "false" ]; then
    echo "Timeout reached. Selenium Hub is not ready."
    exit 1
fi

duration=$SECONDS
echo "Total script execution time: $(($duration / 60)) minutes and $(($duration % 60)) seconds."