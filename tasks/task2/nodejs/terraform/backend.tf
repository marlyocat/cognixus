terraform {
  backend "s3" {
    bucket = "terraform-tfstate-maintainer"
    key    = "terraform/task2/nodejs/terraform.tfstate"
    region = "ap-southeast-1"
  }
}