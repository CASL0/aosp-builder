# AWS Terraform サブモジュール

<!-- prettier-ignore-start -->
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2"></a> [ec2](#module\_ec2) | terraform-aws-modules/ec2-instance/aws | ~> 5.0 |
| <a name="module_outbound_security_group"></a> [outbound\_security\_group](#module\_outbound\_security\_group) | terraform-aws-modules/security-group/aws | ~> 5.0 |
| <a name="module_rdp_security_group"></a> [rdp\_security\_group](#module\_rdp\_security\_group) | terraform-aws-modules/security-group/aws | ~> 5.0 |
| <a name="module_ssh_security_group"></a> [ssh\_security\_group](#module\_ssh\_security\_group) | terraform-aws-modules/security-group/aws | ~> 5.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ec2_key_pair"></a> [ec2\_key\_pair](#input\_ec2\_key\_pair) | EC2のキーペア | `string` | `"ec2-key"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2インスタンスタイプ | `string` | `"m7i-flex.8xlarge"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | 各リソースに付与するタグ | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ami"></a> [ami](#output\_ami) | AWS AMI |
| <a name="output_ssh"></a> [ssh](#output\_ssh) | ssh command |
<!-- END_TF_DOCS -->
<!-- prettier-ignore-end -->
