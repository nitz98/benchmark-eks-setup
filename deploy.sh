#!/bin/bash
set -e

#USAGE: ./deploy.sh namespace app_name deploy_tag

region="ap-south-1"

if [ "$#" -lt 3 ];then
    echo "usage: $0 namespace app_name deploy_tag"
    echo "All parameters not provided to script. (Deploy tag might be empty)"
    exit 1
fi

namespace=$1
app=$2
deploy_tag=$3

#Update image of deplyment
kubectl set image deployment $app -n ${namespace}  $app="940937972577.dkr.ecr.${region}.amazonaws.com/$app:${deploy_tag}"

#Check if deployment is successful
kubectl rollout status deployment -n ${namespace} $app

if [ $? == 0 ]; then
 echo "Deployment Successfull"
 exit 0
else
 echo "Deployment Failed"
 exit 2
fi
