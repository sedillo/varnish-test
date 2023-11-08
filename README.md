# Terraform/Ansible Template

## Environment

```bash
Make sure to install awscli and add the access and secret key
```

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
- Document development environment
- k8s install
- add [loki](https://github.com/grafana/loki)
- grafana dashboards
- aws private subnet
- EC2 dynamic ansible inventory
- AWX install
- Fix varnish
- Demo cadvisor
- better way to manage known hosts changing for ansible
