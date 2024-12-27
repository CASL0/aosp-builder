variable "tags" {
  description = "各リソースに付与するタグ"
  type        = map(string)
  default     = {}
}

variable "instance_type" {
  description = "EC2インスタンスタイプ"
  type        = string
  default     = "m7i-flex.8xlarge"
}

variable "ec2_key_pair" {
  description = "EC2のキーペア"
  type        = string
  default     = "ec2-key"
}
