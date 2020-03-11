#Create public Worker node gorup
resource "aws_eks_node_group" "eks_cluster_public_node_group_1" {
  cluster_name             = "GE_CIDR_TST_Cluster"
  node_group_name          = "GE_CIDR_TST_Cluster_NG_1"
  node_role_arn            = "arn:aws:iam::682651395775:role/eksctl-GE-EKS-CIDR-nodegroup-eks-NodeInstanceRole-SUB3R388JYGC"
  scaling_config {
      desired_size = "1"
      min_size     = "1"
      max_size     = "4"
  }
  subnet_ids               = var.public_subnets
  instance_types           = var.instance_types
  version                  = var.eks_version
}

resource "aws_eks_node_group" "eks_cluster_public_node_group_2" {
  cluster_name             = "GE_CIDR_TST_Cluster"
  node_group_name          = "GE_CIDR_TST_Cluster_NG_2"
  node_role_arn            = "arn:aws:iam::682651395775:role/eksctl-GE-EKS-CIDR-nodegroup-eks-NodeInstanceRole-SUB3R388JYGC"
  scaling_config {
      desired_size = "1"
      min_size     = "1"
      max_size     = "4"
  }
  subnet_ids               = var.public_subnets
  instance_types           = var.instance_types
  version                  = var.eks_version
}