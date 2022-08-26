variable "instance_name" {
  description = "EC2 name for instance"
  type        = string
  default     = "dialloM2iTerraformEC2"
}

variable "instance_region" {
  description = "AWS region for instance"
  type        = string
  default     = "us-west-2"
}
