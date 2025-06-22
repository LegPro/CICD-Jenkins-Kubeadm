output "jenkins_master_public_ip" {
  value = module.jenkins_master.public_ip
}

output "k8s_master_public_ip" {
  value = module.jenkins_slave_k8s_master.public_ip
}

output "k8s_worker_public_ip" {
  value = module.k8s_worker.public_ip
}