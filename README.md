### IaC-NGP-AWS

Steps to use

1. Create an s3 Bucket to store the templates.
2. Run `bash bin/configure.sh`.
3. Click `yes` for required modules.
4. Click `link` to open the console with Cloudfront.

### Components

#### ECS

Amazon EC2 Container Service (Amazon ECS) is a container management service that makes it easy to run, stop, and manage Docker containers on a cluster of Amazon Elastic Compute Cloud (Amazon EC2) instances.

The following template deploys a web application in an Amazon ECS container with cluster, autoscaling and an application load balancer.

#### Getting Started

These instructions will get you a idea of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

#### ECSCluster

An Amazon EC2 Container Service (Amazon ECS) cluster is a logical grouping of container instances that you can place tasks on. 

#### ECSAutoScalingGroup

The ASG is controlling our resource. When the application required more resources for the proper functioning, it allocates more resources. while in the opposite case, it reduces the existing resources.

#### ECSAutoscalingLC

ECSAutoscalingLaunchConfiguration attaches configuration credentials for new resources made by ASG.

#### EC2Role

We can delegate permission to make API requests using EC2Role so that our application can securely make API requests from instances in Auto Scaling groups. 

#### ECSServicePolicy

It add permissions to EC2Role.

#### EC2InstanceProfile

An instance profile is a container for an IAM role that you can use to pass role information to an EC2 instance when the instance starts.
