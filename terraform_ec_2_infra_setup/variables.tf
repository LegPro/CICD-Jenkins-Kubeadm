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