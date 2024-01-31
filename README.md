# benchmark-eks-setup


## Task 

 ```
Refer to this repo: https://github.com/ranupratapsingh/benchmarks

This repo contains 4 small backend applications in different languages.

 
Pick any 2 of them, and create deployment scripts for them in HA setup.

Assume AWS as cloud.
Number of server instances should be configurable
Load balancer(e.g. AWS ALB) configuration to be part of assignment
You Should cover
Server provisioning
Config management
Subsequent deployment
You can do it without without kuberntes.
 

Try ensuring best practices & quality(ease of understanding and well documented).
 ```

## Approach

Use AWS as a Cloud Provider

Use Terraform for infrastructure provisioning with s3 as backend and dynamodb.

Use Jenkins for CI/CD

Use docker for containerization

AWS Eks as orchestration tool

Application Routing via nginx-ingress


### Used below command for infra provisioning

Initializes a Terraform working directory by downloading providers and initializing backend.
```bash
$ terraform init
```
Checks the Terraform configuration files for syntax errors and other basic errors.
```bash
$ terraform validate
```
Rewrites Terraform configuration files to a canonical format.
```bash
$ terraform fmt
```

Creates an execution plan showing what actions Terraform will take to apply the configuration
```bash
$ terraform plan 
```

Applies the changes specified in the Terraform configuration, creating or modifying resources.

```bash
$ terraform apply 
```

Destroys the resources created by Terraform, effectively terminating the infrastructure.
```bash
$ terraform destroy
```

## Infra Creation


### Backend creation

This backend will create an S3 bucket with versioning enabled and a DynamoDB table for managing Terraform state locks

```bash
$ cd benchmark-eks-setup/infra-setup/backend
$ terraform init
$ terraform plan
$ terraform apply
```
![build Job Image](./images/bucket.png)

### Create VPC

The VPC where application will be deployed. It will create both public and private subnet.

```bash
$ cd benchmark-eks-setup/infra-setup/vpc
$ terraform init
$ terraform plan
$ terraform apply
```
![build Job Image](./images/vpc.png)

### Create Bastion Server

Bastion service to access the cluster

```bash
$ cd benchmark-eks-setup/infra-setup/bastion
$ terraform init
$ terraform plan
$ terraform apply
```
![build Job Image](./images/jump.png)

### Create EKS Cluster

Creating eks cluster with 1 worker node. 

```bash
$ cd benchmark-eks-setup/infra-setup/eks-infra
$ terraform init
$ terraform plan
$ terraform apply
```
![build Job Image](./images/eks.png)

### EKSCTL setup

Run the below command on bastion server to connect to EKS using kubectl 

```bash
$ aws eks update-kubeconfig --region ap-south-1 --name cluster-name
```


## Dockerization

### Using ecr repo for storing docker images 

Create ecr repo as per app name

### EXPRESS_API

We have created a Jenkins file to build a Docker image for the "express_api" project

docker-build.sh builds the image with a tag and pushed to ECR.

##### Note: For code uniformity Port is changed to 3000 in express_api/config/env.js file


#### We have implemented multistaging docker file which has reduced image size from 1.13gb to 163mb. 

![ docker Image](./images/multistaging-express.png)

####  express image: without multistaging
####  express1 image: with multistaging

### RAILS_API

We have created a Jenkins file to build a Docker image for the "rails_api" project

docker-build.sh builds the image with a tag and pushed to ECR.


## CI/CD

### Build job url : http://3.6.35.80:8080/job/Build/
Created multibranch pipeline so that we can build multiple branches. The job will build , dockerize the app and push image to ecr.

![build Job Image](./images/buildjob.png)


#### Deploy job url: http://3.6.35.80:8080/job/Deploy/job/Deploy-apps/

Created paramaterized job deployment of multiple apps to eks cluster.
User can select namespace, app name and tag which he want to deploy.
Tag will be automatically fetched from ECR using groovy script. Groovy script is available in kubernetes folder.

![Deploy Job Image](./images/deployjob.png)


## Kubernetes

####  Application deployed to kubernetes cluster using manifest present in kubernetes folder.

![\K8 resources Image](./images/ing.png)


Application is accessible at below endpoints:

###### http://test.express.com/api/benchmarks

![\express Image](./images/test-express.png)

###### http://test.rails.com/api/benchmarks

### Note: Since I have not created any DNS please use below host entry to access it on browser

#### 3.108.114.26 test.rails.com test.express.com

#### 65.1.190.208 test.rails.com test.express.com