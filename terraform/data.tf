# Get all VPCs
data "aws_vpcs" "all" {}

# Pick first available VPC
data "aws_vpc" "selected" {
  id = element(data.aws_vpcs.all.ids, 0)
}

# Get subnets
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

# Amazon Linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}