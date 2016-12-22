#!/bin/bash

set -o errexit -o xtrace

echo -e "\nEnter the name for s3bucket to store the Cloudformation Templates"
read BUCKET_NAME
zip deploy/templates.zip ecs-refarch-continuous-deployment.yaml templates/*

aws s3 cp deploy/templates.zip "s3://${BUCKET_NAME}" --acl public-read
aws s3 cp ngp-stack.yaml "s3://${BUCKET_NAME}" --acl public-read
aws s3 cp --recursive templates/ "s3://${BUCKET_NAME}/templates" --acl public-read
