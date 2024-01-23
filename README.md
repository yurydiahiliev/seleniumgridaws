# AWS Cloudformation Stack for Selenium Grid 4

This project includes AWS Cloudformation template with start and clean-up shell scripts to create and stop AWS Stacks.
The main idea to create Selenium Hub and Selenium Nodes on AWS Spot Fleet instances pre-created before.
This configuration supports nodes creation based on official Chrome browser docker images from Selenium Docker Hub.
Stack allows to gain and run all resources on the separated AWS Fleet instances in parallel.

## Pre-requisites

Install the required utilites `curl`, `jq`, `aws-cli` for running sh scripts


## Set up

Enter to your AWS Account using `aws-cli` tool to be able to run AWS modules

1. In `params.json` file you can indicate all your parameters that you want to use during AWS Stack creation

Or you can use custom fast line URL for stack creation:

US East (N. Virginia) | us-east-1 | [![Launch Stack](https://cdn.rawgit.com/buildkite/cloudformation-launch-stack-button-svg/master/launch-stack.svg)](https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/create/review
   ?templateURL=https://cf-templates-1lfo03l9lq9gl-us-east-1.s3.amazonaws.com/2024-01-23T101248.725Z7qa-cloudformation-selenium-grid.yml
   &stackName=seleniumgridaws
   &param_stackName=seleniumgridaws
   &param_AvailabilityZoneFull=us-east-1a) 

Or you can run adapted sh script with nessessary waiting and retrieving Selenium Grid URL after finishing

`sh create_stack.sh`

Avarage time for creation ~ 5-6 min


## Clean-up
For deleting AWS Stack and all AWS resources combined with created stack use command:

`sh clean_up_stack.sh`

   




