#!/bin/bash
echo "Create virtual environment"
python3 -m venv .venv

echo "Activate virtual environment"
source .venv/bin/activate

echo "Install dependencies"
pip install -r requirements.txt

echo "Install Ansible AWS collection"
ansible-galaxy collection install amazon.aws

echo "Display Ansible inventory graph"
ansible-inventory -i aws_ec2.yaml --graph

echo "Run the Ansible playbook to deploy Kubernetes"
ansible-playbook -i aws_ec2.yaml -u ubuntu --private-key nodejs_ssh_key.pem --extra-vars "ansible_ssh_extra_args='-o StrictHostKeyChecking=no'" deploy_k8s_playbook.yaml

echo "Script Execution Completed"