## IaC NGP AWS - Next Generation platform based on AWS ECS

![Architecture of Next Generation Platform with AWS](/doc/NGP_AWS_Architecture.png)

#### Pre-requisites
- AWS IAM account with administrator privileges (Save your AWS IAM access key ID and secret access key).
- AWS CLI
- An S3 bucket to store the templates.
- Accept Software Terms of AWS Marketplace for CentOS. 
- Setup Tyk Hybrid account from https://cloud.tyk.io/signup for running Tyk API

#### Steps
- Export AWS credentials as bash variables
```
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
export AWS_DEFAULT_REGION="ap-northeast-1"  //(e.g. ap-northeast-1 for Tokyo and ap-southeast-1 for Singapore region)

```
- Clone the repo [IaC-ngp-aws][iac-ngp-aws]
- Change directory to IaC-ngp-aws
- Run bash `bin/configure.sh` to decide which modules to run.
- Give `y` for required modules.
- To create just the infrastructure, give `n` to all the modules.
- Give the S3 bucket name when requested.
- Provide the aws region(when requested) where you need to create the stack.
- Click the `link` to open the CloudFormation console with template URL already in place.
- Provide the requested parameters in the AWS CloudFormation console.
- Important - Click the checkbox "I acknowledge that AWS CloudFormation might create IAM resources with custom names." under Capabilities section.
- Review the information for the stack. When you're satisfied with the settings, click 'Create'.
- To monitor the progress of the stack, select your stack and in the Stack Details pane, click the Events tab.
- To delete the stack and its resources, from the AWS CloudFormation console, select the stack and click Delete.

#### Quick Troubleshooting.

1. Ensure the access from terminal, check with `aws s3 ls`.
2. If there are errors regarding AMI's , please search for community ami's with `amazon-ecs-optimized` and update mappings in `modules/ecs/ecs.yaml`.

#### Steps to Import a New Module

- Create a folder with module-name in modules directory and add the following files within that folder:
(Refer [Infrastructure][infrastructure] Module)
  a. module.yaml : The CloudFormation template to create the module.
  b. ngp-parameters-addon.yaml : User Input parameters required for module.
  c. ngp-resource-addon.yaml : The pluggable part that integrates module with main CloudFormation Stack
- Add module-name to module array in bin/configure.sh.

# Components

## ECS

Amazon EC2 Container Service (Amazon ECS) is a container management service that makes it easy to run, stop, and manage Docker containers on a cluster of Amazon Elastic Compute Cloud (Amazon EC2) instances.

The following template deploys a web application in an Amazon ECS container with cluster, autoscaling and an application load balancer.

##### Getting Started

These instructions will get you a idea of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

##### ECSCluster

An Amazon EC2 Container Service (Amazon ECS) cluster is a logical grouping of container instances that you can place tasks on. 

##### ECSAutoScalingGroup

The ASG is controlling our resource. When the application required more resources for the proper functioning, it allocates more resources. while in the opposite case, it reduces the existing resources.

##### ECSAutoscalingLC

ECSAutoscalingLaunchConfiguration attaches configuration credentials for new resources made by ASG.

##### EC2Role

We can delegate permission to make API requests using EC2Role so that our application can securely make API requests from instances in Auto Scaling groups. 

##### ECSServicePolicy

It add permissions to EC2Role.

##### EC2InstanceProfile

An instance profile is a container for an IAM role that you can use to pass role information to an EC2 instance when the instance starts.
## Tyk

Once the TYK definition are created, we need to manually give the Tyk Credentials to activate Tyk.
