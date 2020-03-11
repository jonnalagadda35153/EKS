variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region to use for the infrastructure creation"
}

variable "cluster_name" {
  type        = string
  default     = "CI_Cluster"
  description = "Name of EKS cluster to append securty group names"
}

variable "vpc_id" {
  type        = string
  default     = "vpc-01b579cdbb7bf5d94"
  description = "VPC id for the securty group to be attached"
}

variable "s3_bucket" {
  type        = string
  default     = "ge-tf-session-bucket"
  description = "S3 bucket to store session data"
}

variable "dev_path" {
  type        = string
  default     = "EKS_IAM/dev/eks_security_group.tfstate"
  description = "Path to store the dev state"
}