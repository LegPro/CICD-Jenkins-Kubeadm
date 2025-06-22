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

