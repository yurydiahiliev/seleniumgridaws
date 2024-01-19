#!/bin/sh
STACK_NAME="seleniumgridaws"
SECONDS=0

echo "Starting to create AWS Cloudformation Stack: ${STACK_NAME}"

aws cloudformation create-stack \
    --template-body file://cloudformation-selenium-grid.yml \
    --stack-name $STACK_NAME \
    --capabilities CAPABILITY_NAMED_IAM

echo "Waiting for [$STACK_NAME] stack creation..."

aws cloudformation wait stack-create-complete \
    --stack-name $STACK_NAME \
    --output text