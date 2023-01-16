#!/usr/bin/env zsh

# Parameters
# $1 = Account ID
# $2 = App name
#There parameters are passed by the ECS Repository provisioner.

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $1.dkr.ecr.us-east-1.amazonaws.com

docker build -t $2-repository:$2-v1 -f ../../FinancialManagement/Deployment/Dockerfile ../../

docker tag $2-repository:$2-v1 $1.dkr.ecr.us-east-1.amazonaws.com/$2-repository:$2-v1

docker push $1.dkr.ecr.us-east-1.amazonaws.com/$2-repository:$2-v1