terraform {
  backend "s3" {
    bucket = "terraform-tfstate-maintainer"
    key    = "terraform/task1/gitea/terraform.tfstate"
    region = "ap-southeast-1"
  }
}