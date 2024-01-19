#!/bin/sh

STACK_NAME="seleniumgridaws"
echo "Starting to delete AWS Cloudformation Stack with name: $STACK_NAME"
aws cloudformation delete-stack --stack-name $STACK_NAME
echo "Waiting for deleting AWS Cloudformation Stack with name: $STACK_NAME"
aws cloudformation wait stack-delete-complete --stack-name $STACK_NAME
echo "Deleted stack successfully!"