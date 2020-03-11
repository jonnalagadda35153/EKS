#Cloud vendor is AWS and region is us-east-1
provider "aws" {
  region  = var.region
}

terraform {
  backend "s3" {
    bucket = "ge-tf-session-bucket"
    key    = "EKS_Security_Groups/dev/eks_security_group.tfstate"
    region = "us-east-1"
  }
}

#Creating a base security group to be attached to EKS Master
resource "aws_security_group" "eks_security_group" {
  name          = "${var.cluster_name}_sg"
  description   = "Security Group for EKS cluster"
  vpc_id        = var.vpc_id
  tags          = {
    Name        = "${var.cluster_name}_ControlPlaneSecurityGroup"
    Environment = "CI"
  }
}

#Worker node security group
resource "aws_security_group" "eks_worker_security_group" {
    name        = "${var.cluster_name}_worker_sg"
    description = "Security group for EKS worker nodes"
    vpc_id      = var.vpc_id
    tags          = {
      Name        = "${var.cluster_name}_worker_sg"
      Environment = "CI"
  }  
}

#Security group rule to establish communication between master and worker nodes
resource "aws_security_group_rule" "eks_worker_security_group_ingress" {
  description              = "Security Group rule to establish communication between nodes and master"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = join("", aws_security_group.eks_security_group.*.id)
  security_group_id        = join("", aws_security_group.eks_worker_security_group.*.id)
  type                     = "ingress"
}

#Security group rule to establish HTTPS communication between master and worker nodes 
resource "aws_security_group_rule" "eks_worker_security_group_https_ingress" {
  description              = "Security Group rule to establish communication between nodes and master"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = join("", aws_security_group.eks_security_group.*.id)
  security_group_id        = join("", aws_security_group.eks_worker_security_group.*.id)
  type                     = "ingress"
}

#Egress security group rule for worker nodes
resource "aws_security_group_rule" "eks_worker_security_group_egress" {
  description       = "Allow all egress traffic"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.eks_worker_security_group.*.id)
  type              = "egress"
}

#Ingress https security group rule for EKS master
resource "aws_security_group_rule" "eks_master_https_ingress" {
  description              = "Security Group rule to establish communication between nodes and master"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = join("", aws_security_group.eks_worker_security_group.*.id)
  security_group_id        = join("", aws_security_group.eks_security_group.*.id)
  type                     = "ingress"
}

#Egress security group rule for EKS master
resource "aws_security_group_rule" "eks_master_egress" {
  description              = "Allow all egress traffic"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = join("", aws_security_group.eks_security_group.*.id)
  source_security_group_id = join("", aws_security_group.eks_worker_security_group.*.id)
  type                     = "egress"
}

#Egress security group rule for EKS master
resource "aws_security_group_rule" "eks_master_https_egress" {
  description              = "Allow all egress https traffic"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = join("", aws_security_group.eks_security_group.*.id)
  source_security_group_id = join("", aws_security_group.eks_worker_security_group.*.id)
  type                     = "egress"
}