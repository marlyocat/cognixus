resource "aws_iam_role" "nodejs_k3s_role" {
  name = "K3sIAMRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "nodejs_k3s_admin_access" {
  role       = aws_iam_role.nodejs_k3s_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "nodejs_k3s_instance_profile" {
  name = "K3sInstanceProfile"
  role = aws_iam_role.nodejs_k3s_role.name
}