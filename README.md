# AWS CloudFormation Stack for Selenium Grid 4

This project provides an AWS CloudFormation template along with start and clean-up shell scripts for managing AWS Stacks. It focuses on setting up a Selenium Hub and Nodes on AWS Spot Fleet instances. The setup utilizes official Chrome browser Docker images from Selenium Docker Hub and supports parallel resource execution on separate AWS Fleet instances.


## Pre-requisites

Before starting, ensure `curl`, `jq`, and `aws-cli` are installed as they are essential for executing the provided shell scripts.


## Setup

First, configure your AWS account with `aws-cli`. This is necessary for running AWS modules.

### Options for Stack Creation

- **Using Parameters**: Modify the `params.json` file with your desired parameters for AWS Stack creation.
- **Fast Launch URL**: Use the following URL for quick stack creation in the US East (N. Virginia) region.

  | Region Name        | Region Code | Launch Link |
  | ------------------ | ----------- | ----------- |
  | US East (N. Virginia) | us-east-1 | [![Launch Stack](https://cdn.rawgit.com/buildkite/cloudformation-launch-stack-button-svg/master/launch-stack.svg)](https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/create/review?templateURL=https://cf-templates-1lfo03l9lq9gl-us-east-1.s3.amazonaws.com/2024-01-23T101248.725Z7qa-cloudformation-selenium-grid.yml&stackName=seleniumgridaws&param_stackName=seleniumgridaws&param_AvailabilityZoneFull=us-east-1a) |

- **Shell Script**: Alternatively, execute the adapted shell script to create the stack and retrieve the Selenium Grid URL upon completion.

  ```bash
  sh create_stack.sh
  ```


Avarage time for creation ~ 5-6 min


## Clean-up

To delete the AWS Stack and all associated resources, use the following command:

  ```bash
  sh clean_up_stack.sh
  ```


   




