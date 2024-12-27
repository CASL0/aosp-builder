locals {
  tags = {
    Name      = "AOSP"
    Terraform = true
  }
}

module "aws_resources" {
  source = "./modules/aws"

  ec2_key_pair = "ec2-key"

  tags = local.tags
}
