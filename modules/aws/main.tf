locals {
  name = "aosp"
  cidr = "10.0.0.0/24"
  azs  = slice(data.aws_availability_zones.available.names, 0, 1)

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y && apt-get install -y \
      git-core \
      gnupg \
      flex \
      bison \
      build-essential \
      zip \
      curl \
      zlib1g-dev \
      libncurses5 \
      x11proto-core-dev \
      libx11-dev \
      libgl1-mesa-dev \
      libxml2-utils \
      xsltproc \
      unzip \
      fontconfig
    ln -s /usr/bin/python3 /usr/bin/python
    curl -o /usr/bin/repo https://storage.googleapis.com/git-repo-downloads/repo
    chmod a+x /usr/bin/repo
  EOF
}

data "aws_availability_zones" "available" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.name
  cidr = local.cidr

  azs            = local.azs
  public_subnets = [for k, v in local.azs : cidrsubnet(local.cidr, 4, k)]

  tags = var.tags
}

module "ssh_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "ssh-access"
  description = "Security group that allows SSH access"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]

  tags = var.tags
}

module "rdp_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "rdp-access"
  description = "Security group that allows RDP access"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["rdp-tcp"]

  tags = var.tags
}

module "outbound_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "outbound-access"
  description = "Security group that allows all outbound"
  vpc_id      = module.vpc.vpc_id

  egress_rules = ["all-all"]

  tags = var.tags
}

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  name          = local.name
  ami           = data.aws_ami.ubuntu.id
  instance_type = "m7i-flex.8xlarge"
  key_name      = "ec2-key"

  availability_zone = element(module.vpc.azs, 0)
  subnet_id         = element(module.vpc.public_subnets, 0)
  vpc_security_group_ids = [
    module.ssh_security_group.security_group_id,
    module.rdp_security_group.security_group_id,
    module.outbound_security_group.security_group_id
  ]
  associate_public_ip_address = true

  user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = true

  root_block_device = [
    {
      encrypted   = false
      volume_type = "gp3"
      volume_size = 500
    },
  ]

  tags = var.tags
}
