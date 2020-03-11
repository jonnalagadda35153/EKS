variable "region" {
  type        = string
  default     = "us-west-2"
  description = "Region to use for the infrastructure creation"
}

variable "cluster_name" {
  type        = string
  default     = "CI_Cluster"
  description = "Name of EKS cluster to append securty group names"
}

variable "eks_role_arn" {
  type        = string
  default     = "arn:aws:iam::682651395775:role/aws_eks_role"
  description = "EKS Master Role ARN"
}

variable "s3_bucket" {
  type        = string
  default     = "ge-tf-session-bucket"
  description = "S3 bucket to store session data"
}

variable "dev_path" {
  type        = string
  default     = "EKS_IAM/dev/eks_dev.tfstate"
  description = "Path to store the dev state"
}

variable "vpc_id" {
  type        = string
  default     = "vpc-01b579cdbb7bf5d94"
  description = "VPC id for the EKS cluster to spin up"
}

variable "public_subnets" {
  type        = list(string)
  default     = ["subnet-023c3821506c6dce2", "subnet-0e7ab60f1390423ae"]
  description = "Public Subnets that will be used to create the EKS cluster"
}

variable "private_subnets" {
  type        = list(string)
  default     = ["subnet-0c2f7abf9e68baa91","subnet-0c8ac3a16b0849fa1","subnet-0429c2658c49e5e29"]
  description = "Private Subnets that will be used to create the EKS cluster"
}

variable "eks_version" {
  type        = string
  default     = "1.14"
  description = "EKS version"
}

variable "eks_master_sg" {
  type        = list(string)
  default     = ["sg-0c92b449ba4c58555"]
  description = "Security Group for EKS master"
}

variable "worker_node_sg" {
  type        = string
  default     = "sg-0466177005f405cd3"
  description = "Worker node sg"
}

variable "ng_name_pub" {
  type        = string
  default     = "public_node_gorup"
  description = "Name of public node group"
}

variable "ng_name_pri" {
  type        = string
  default     = "private_node_gorup"
  description = "Name of private node group"
}
 
variable "worker_node_arn" {
  type        = string
  default     = "arn:aws:iam::682651395775:role/aws_eks_worker_role"
  description = "Worker Node Role"
}

variable "desired" {
  type        = string
  default     = "1"
  description = "desired node count"
}
 
variable "max" {
  type        = string
  default     = "2"
  description = "desired node count"
}

variable "min" {
  type        = string
  default     = "1"
  description = "desired node count"
}

variable "instance_types" {
  type        = list(string)
  default     = ["t2.medium"]
  description = "Worer node ami type"
}
