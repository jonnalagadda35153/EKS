provider "aws" {
  region  = var.region
}

terraform {
  backend "s3" {
    bucket = "ge-tf-session-bucket"
    key    = "EKS/dev/eks_master_dev.tfstate"
    region = "us-west-2"
  }
}

#Create EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name                      = "GE_CIDR_TST_Cluster"
  role_arn                  = "arn:aws:iam::682651395775:role/eksctl-GE-EKS-CIDR-cluster-ServiceRole-FP1L4NUEGP55"
  vpc_config {
    #vpc_id = "vpc-0674822c23b03659e"
    subnet_ids = var.public_subnets
    security_group_ids = var.eks_master_sg
  }
  version                   = var.eks_version
  enabled_cluster_log_types = ["api", "audit"]

  tags = {
    "Name" = "GE_CIDR_TST_Cluster"
  }
}
