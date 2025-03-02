// VPC
variable "vpc_cidr" {
  type    = string
  default = "10.128.0.0/16"
}

// EC2
variable "ec2_ami_id" {
  type    = string
  default = "ami-0b03299ddb99998e9"
}

variable "ec2_vol_size" {
  type    = number
  default = 8
}

variable "ec2_instance_count" {
  type    = number
  default = 1
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}