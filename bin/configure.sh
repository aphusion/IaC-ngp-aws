#!/usr/bin/env bash
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

modules=("infrastructure" "ecs")
services=("nginx" "tyk")
VERSION=master
echo -e "\nPlease specify the preferred version of the application (Leave empty for the master version).
You can find the latest release version here.${GREEN}https://github.com/microservices-today/IaC-ngp-aws/releases.${NC}"
read VERSION
if [[ -z "$VERSION" ]]; then
    VERSION=master
    else
   git checkout tags/$VERSION
fi

for module in "${modules[@]}"
do
   echo -e "Do you want to run ${GREEN}$module${NC} ? y/n"
   read ANS
   if [ ${ANS} == 'y' ]
   then
   aws cloudformation create-stack --stack-name $module-stack --template-body file://modules/$module/${module}.yaml --parameters file://modules/$module/${module}-parameters.json --capabilities CAPABILITY_IAM
   fi
done
echo -e "Do you want to create ${GREEN}Services${NC} on the cluster ? y/n"
read ANS
if [ ${ANS} == 'y' ]
  then
   for service in "${services[@]}"
	 do
	   echo -e "Do you want to run ${GREEN}$service${NC} ? y/n"
	   read ANS
	   if [ ${ANS} == 'y' ]
	   then
	   aws cloudformation create-stack --stack-name $service-stack --template-body file://modules/$module/$service/${service}.yaml --parameters file://modules/$module/$service/${service}-parameters.json --capabilities CAPABILITY_IAM
	   fi
	 done
fi

