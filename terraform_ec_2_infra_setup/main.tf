module "jenkins_master" {
  source       = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.0"
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
  version = "5.6.0"
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
  version = "5.6.0"
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