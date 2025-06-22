# Terraform-Based Infrastructure Provisioning for Jenkins + Kubernetes Cluster

**Assignment**: Jenkins CICD Infrastructure Setup via Terraform
**Author**: Vinay Hinukale
**Objective**: Provision a reusable, scalable, and modular EC2 infrastructure for Jenkins Master, Jenkins Slave/Kubernetes Master, and Kubernetes Worker using industry-standard Terraform practices.

---

## Prerequisite

Before running Terraform, ensure you have one EC2 instance (e.g., Amazon Linux 2) up and running. This instance will serve as the **Terraform Controller** (the machine from which Terraform commands are executed). Install and configure the following on the Terraform Controller:

* Terraform CLI (v1.12.x or compatible)
* IAM access and secret key for AWS manually created (no AWS CLI needed)
* SSH key pair already created in AWS (for remote access to EC2 instances)

After creating the IAM user, go to **Security Credentials** tab and click **Create access key**. Store the access key and secret securely as this is shown only once.

The IAM user must have these policies attached:

* `AmazonEC2FullAccess`
* `AmazonSSMReadOnlyAccess`

---

## Requirements

Provision the following EC2 instances using Terraform:

| EC2 Role                   | Instance Type | Purpose                                |
| -------------------------- | ------------- | -------------------------------------- |
| Jenkins Master             | t2.micro      | Runs Jenkins Web UI                    |
| Jenkins Slave + K8s Master | t2.medium     | Runs Jenkins agent + Kubernetes master |
| Kubernetes Worker Node     | t2.medium     | Runs workload containers               |

---

## Project Structure (Industry Standard)

```
terraform-ec2-infra/
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars
```

---

## Root `main.tf`

```hcl
module "jenkins_master" {
  source       = "terraform-aws-modules/ec2-instance/aws"
  version      = "5.6.0"
  name         = "jenkins-master"
  instance_type = "t2.micro"
  ami          = var.ami_id
  subnet_id    = var.subnet_id
  key_name     = var.key_pair
  vpc_security_group_ids = [var.security_group_id]
  tags = {
    Role = "JenkinsMaster"
  }
}

module "jenkins_slave_k8s_master" {
  source       = "terraform-aws-modules/ec2-instance/aws"
  version      = "5.6.0"
  name         = "jenkins-slave-k8s-master"
  instance_type = "t2.medium"
  ami          = var.ami_id
  subnet_id    = var.subnet_id
  key_name     = var.key_pair
  vpc_security_group_ids = [var.security_group_id]
  tags = {
    Role = "JenkinsSlaveK8sMaster"
  }
}

module "k8s_worker" {
  source       = "terraform-aws-modules/ec2-instance/aws"
  version      = "5.6.0"
  name         = "k8s-worker-node"
  instance_type = "t2.medium"
  ami          = var.ami_id
  subnet_id    = var.subnet_id
  key_name     = var.key_pair
  vpc_security_group_ids = [var.security_group_id]
  tags = {
    Role = "K8sWorker"
  }
}
```

---

## `providers.tf`

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.99.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
```

---

## `variables.tf`

```hcl
variable "aws_region" {
  description = "AWS region to deploy resources (e.g., ap-south-1)"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to be used for EC2 instances"
  type        = string
}

variable "key_pair" {
  description = "Existing AWS EC2 key pair name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where EC2 instances will be launched"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID attached to EC2 instances"
  type        = string
}

variable "aws_access_key" {
  description = "Your AWS access key"
  type        = string
}

variable "aws_secret_key" {
  description = "Your AWS secret key"
  type        = string
  sensitive   = true
}
```

---

## `terraform.tfvars`

```hcl
# AWS Region - Find in EC2 dashboard top-right (e.g., ap-south-1 for Mumbai)
aws_region = "ap-south-1"

# AMI ID - Go to EC2 > AMIs, filter by "Amazon Linux 2", copy AMI ID
ami_id = "ami-0e001c9271cf7f3b9"

# Key Pair - Go to EC2 > Key Pairs. Use only the name (without .pem extension)
key_pair = "your-key-name"

# Subnet ID - Go to VPC > Subnets, copy a public subnet ID
subnet_id = "subnet-xxxxxxxx"

# Security Group ID - Go to EC2 > Security Groups, use one that allows SSH, HTTP, and Kubernetes ports
security_group_id = "sg-xxxxxxxx"

# IAM Credentials - Created from AWS Console > IAM > Users > Security Credentials
aws_access_key        = "youraccesskey"
aws_secret_key        = "yoursecretkey"
```

Replace `youraccesskey` and `yoursecretkey` with credentials from an IAM user having required permissions.

---

## `outputs.tf`

```hcl
output "jenkins_master_public_ip" {
  value = module.jenkins_master.public_ip
}

output "k8s_master_public_ip" {
  value = module.jenkins_slave_k8s_master.public_ip
}

output "k8s_worker_public_ip" {
  value = module.k8s_worker.public_ip
}
```

---

## Usage Instructions

```bash
cd terraform-ec2-infra
terraform init
terraform plan
terraform apply
```

---

## Result

This Terraform setup will deploy:

* One t2.micro EC2 as Jenkins Master
* One t2.medium EC2 as Jenkins Slave + Kubernetes Master
* One t2.medium EC2 as Kubernetes Worker

All instances will be tagged, reusable, and managed through declarative infrastructure as code.

---

## To Destroy Infrastructure

If the environment is no longer needed, destroy all resources using:

```bash
terraform destroy
```

This will prompt for confirmation and remove all resources created by this setup.
