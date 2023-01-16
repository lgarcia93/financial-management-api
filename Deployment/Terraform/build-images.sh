#!/usr/bin/env zsh

#Build product service image
docker build -t financial-management-repository:financial-management-v1 -f ../../FinancialManagement/Deployment/Dockerfile ../../

docker tag financial-management-repository:financial-management-v1 $1.dkr.ecr.us-east-1.amazonaws.com/financial-management-repository:financial-management-v1

docker push $1.dkr.ecr.us-east-1.amazonaws.com/financial-management-repository:financial-management-v1