#!/bin/sh

STACK_NAME="seleniumgridaws"

# Retrieve the Stack ID
STACK_ARN=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --query 'Stacks[0].StackId' --region "us-east-1" --output text)
STACK_ID=$(echo "$STACK_ARN" | awk -F'/' '{print $NF}')

echo "Deleting SSM parameter for Stack ID: $STACK_ID"

# Delete SSM parameter
aws ssm delete-parameter --name "SeleniumHubPublicIP-$STACK_ID" --region "us-east-1"

echo "SSM parameter deleted."

echo "Starting to delete AWS Cloudformation Stack with name: $STACK_NAME"
aws cloudformation delete-stack --stack-name $STACK_NAME
echo "Waiting for deleting AWS Cloudformation Stack with name: $STACK_NAME"
aws cloudformation wait stack-delete-complete --stack-name $STACK_NAME
echo "Deleted stack successfully!"