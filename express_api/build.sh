#!/bin/bash
set -e

#Go to root directory
BASEDIR=$(dirname "$0")

#Account variables
AWS_REGION="ap-south-1"
REGISTRY="940937972577.dkr.ecr.ap-south-1.amazonaws.com"

epoch=$(date +%s)
tag="${epoch}"
git_branch=${BRANCH_NAME}
ecr_repo_name="express-api"
echo "$tag" > docker-tag.txt

aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 940937972577.dkr.ecr.ap-south-1.amazonaws.com
#$(aws ecr get-login --no-include-email --region ${AWS_REGION})

echo "*** Building Docker image: ${REGISTRY}/${ecr_repo_name}:${tag} ***"
docker build -t ${REGISTRY}/${ecr_repo_name}:${tag} .
echo "Image built successfully".

echo "Pushing image to Docker Registry."
docker push ${REGISTRY}/${ecr_repo_name}:${tag}
echo "Image pushed successfully."

docker rmi -f ${REGISTRY}/${ecr_repo_name}:${tag}
echo "Deleted image from build server."
