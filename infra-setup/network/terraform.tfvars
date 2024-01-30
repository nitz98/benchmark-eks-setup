vpc_name                     = "infra-vpc"
vpc_cidr                     = "10.10.0.0/16"
az                           = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
private_subnet_cidrs         = ["10.10.3.0/24", "10.10.4.0/24", "10.10.5.0/24"]
public_subnet_cidrs          = ["10.10.1.0/24", "10.10.2.0/24"]
