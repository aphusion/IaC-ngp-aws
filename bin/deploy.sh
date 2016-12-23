#!/bin/bash

set -o errexit -o xtrace

BUCKET_NAME=sample
echo -e "Enter the name for s3bucket to store the Cloudformation Templates"
read BUCKET_NAME

zip deploy/templates.zip ngp-stack.yaml modules/**/*.yaml

aws s3 cp deploy/templates.zip "s3://${BUCKET_NAME}" --acl public-read
aws s3 cp ngp-stack.yaml "s3://${BUCKET_NAME}" --acl public-read
aws s3 cp --recursive modules/ "s3://${BUCKET_NAME}/templates" --acl public-read
