resource "aws_instance" "gitea_app" {
  count                  = var.ec2_instance_count
  instance_type          = var.ec2_instance_type
  ami                    = var.ec2_ami_id
  vpc_security_group_ids = [aws_security_group.gitea_security_group.id]
  subnet_id              = aws_subnet.gitea_public_subnet[count.index].id
  
  root_block_device {
    volume_size = var.ec2_vol_size
  }

  tags = {
    Name = "gitea-app-${count.index + 1}"
    Application = "gitea"
  }

  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${self.id} --region ap-southeast-1"
  }

  user_data = file("./bash/install_gitea.sh")
}