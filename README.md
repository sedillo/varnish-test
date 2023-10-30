# Terraform/Ansible Template

## Setup

```bash
cd terraform
terraform plan
terraform apply --auto-approve
```

The terraform commands will 
- create the infrastructure in AWS
- create local ansible files to connect to EC2 Instances

```bash
cd nsible
ansible-playbook -i inventory main.yml
```

```bash
cd terraform
terraform destroy
```

## Next steps
- k8s install
- grafana dashboards
- EC2 dynamic ansible inventory
- AWX install
- Fix varnish
- Demo cadvisor
- better way to manage known hosts changing for ansible
