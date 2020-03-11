variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region to use for the infrastructure creation"
}

variable "eks_role" {
  type        = string
  default     = "aws_eks_role"
  description = "Role that is going to be build and used for EKS"
}

variable "eks_worker_role" {
  type        = string
  default     = "aws_eks_worker_role"
  description = "Role that will be used for EKS worker nodes"
}

variable "s3_bucket" {
  type        = string
  default     = "ge-tf-session-bucket"
  description = "S3 bucket to store session data"
}

variable "dev_path" {
  type        = string
  default     = "EKS_IAM/dev/eks_iam.tfstate"
  description = "Path to store the dev state"
}