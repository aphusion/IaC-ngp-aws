#!/usr/bin/env bash
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

modules=("ecs" "nginx" "tyk")
VERSION=master
git checkout .
echo -e "\nPlease specify the preferred version of the application (Leave empty for the master version).
You can find the latest release version here.${GREEN}https://github.com/microservices-today/IaC-ngp-aws/releases.${NC}"
read VERSION
if [[ -z "$VERSION" ]]; then
    VERSION=master
    else
   git checkout tags/$VERSION
fi
cat modules/infrastructure/ngp-parameters-addon.yaml >> ngp-parameters.yaml
cat modules/infrastructure/ngp-resource-addon.yaml >> ngp-resources.yaml
for module in "${modules[@]}"
do
   echo -e "Do you want to add ${GREEN}$module${NC} ? y/n"
   read ANS
   if [ ${ANS} == 'y' ]
   then
     cat modules/${module}/ngp-parameters-addon.yaml >> ngp-parameters.yaml
     cat modules/${module}/ngp-resource-addon.yaml >> ngp-resources.yaml
   fi
done

cat ngp-parameters.yaml >> ngp-stack.yaml
cat ngp-resources.yaml >> ngp-stack.yaml

S3_BUCKET_NAME=sample
echo -e "Enter the name for s3 bucket to store the Cloudformation Templates"
read S3_BUCKET_NAME

sed -i -e "s@S3_BUCKET_NAME@${S3_BUCKET_NAME}@g" ngp-stack.yaml

zip deploy/templates.zip ngp-stack.yaml modules/**/*.yaml

aws s3 cp deploy/templates.zip "s3://${S3_BUCKET_NAME}" --acl public-read
aws s3 cp ngp-stack.yaml "s3://${S3_BUCKET_NAME}" --acl public-read
aws s3 cp --recursive modules/ "s3://${S3_BUCKET_NAME}/templates" --acl public-read

echo -e "Enter the AWS REGION to deploy the Cloudformation Stack"
read AWS_REGION
URL="https://console.aws.amazon.com/cloudformation/home?region=${AWS_REGION}#/stacks/new?stackName=ecs-continuous-deployment&templateURL=https://s3.amazonaws.com/${S3_BUCKET_NAME}/ngp-stack.yaml"
echo -e "Open the Link in Browser --- ${GREEN}${URL}${NC}"
if which xdg-open > /dev/null
then
  xdg-open $URL
elif which gnome-open > /dev/null
then
  gnome-open $URL
fi
