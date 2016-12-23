### IaC-NGP-AWS

#### Pre-requisites
1. Install AWS CLI.
2. Clone the Repo.

#### Steps to use

1. Export AWS Variables.

	```
	export AWS_ACCESS_KEY_ID="*******"
	export AWS_SECRET_ACCESS_KEY="*******"
	export AWS_DEFAULT_REGION="********"
	```
	
2. Create an s3 Bucket from AWS Console to store the templates.
3. Run `bash bin/configure.sh`.
4. Click `yes` for required modules.
5. Give the `S3 Bucket Name`
6. Click `link` to open the console with Cloudfront.

#### Quick Troubleshooting.

1. Ensure the access from terminal, check with `aws s3 ls`.
2. If there are errors regarding AMI's , please search for community ami's with `amazon-ecs-optimized` and update mappings in `modules/ecs/ecs.yaml`.

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
