Title: Terraform Setup  
Author: Vinay Hinukale  

## Objective:
Install Terraform on EC2 Amazon Linux

---

## Prerequisite:
- EC2 instance running Amazon Linux

---

## Steps:

### 1. Install `yum-config-manager` to manage your repositories:
```bash
sudo yum install -y yum-utils
```

### 2. Add the official HashiCorp Linux repository using `yum-config-manager`:
```bash
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
```

### 3. Install Terraform from the new HashiCorp repository:
```bash
sudo yum -y install terraform
```

### 4. Verify the Terraform installation:
```bash
terraform -v
```

You should see the installed version of Terraform displayed in the terminal.

---

End of Document

