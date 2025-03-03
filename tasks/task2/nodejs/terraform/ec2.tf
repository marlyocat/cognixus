resource "aws_instance" "nodejs_app" {
  count                  = var.ec2_instance_count
  instance_type          = var.ec2_instance_type
  ami                    = var.ec2_ami_id
  key_name               = aws_key_pair.nodejs_deployer_key.key_name
  vpc_security_group_ids = [aws_security_group.nodejs_security_group.id]
  subnet_id              = aws_subnet.nodejs_public_subnet[count.index].id
  iam_instance_profile   = aws_iam_instance_profile.nodejs_k3s_instance_profile.name
  user_data              = file("./bash/deploy_k3s_with_nodejs_app.sh")

  root_block_device {
    volume_size = var.ec2_vol_size
  }

  tags = {
    Name = "nodejs-app-${count.index + 1}"
    Application = "nodejs"
  }

  provisioner "file" {
    source      = "./k8s_manifest/deployment.yaml"
    destination = "/home/ubuntu/deployment.yaml"
  
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.nodejs_ssh_key.private_key_pem
      host        = self.public_ip
    }
  }

  provisioner "file" {
    source      = "./k8s_manifest/service.yaml"
    destination = "/home/ubuntu/service.yaml"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.nodejs_ssh_key.private_key_pem
      host        = self.public_ip
    }
  }

  provisioner "file" {
    source      = "./k8s_manifest/ingress.yaml"
    destination = "/home/ubuntu/ingress.yaml"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.nodejs_ssh_key.private_key_pem
      host        = self.public_ip
    }
  }

  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${self.id} --region ap-southeast-1"
  }
}

resource "tls_private_key" "nodejs_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "nodejs_deployer_key" {
  key_name   = "nodejs-deployer-key"
  public_key = tls_private_key.nodejs_ssh_key.public_key_openssh
}

resource "local_file" "nodejs_ssh_private_key" {
  filename = "./ansible/nodejs_ssh_key.pem"
  content  = tls_private_key.nodejs_ssh_key.private_key_pem
  file_permission = "0600"
}