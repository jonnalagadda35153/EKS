locals {
  config_map_aws_auth = <<CONFIGMAPAWSAUTH
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: "${var.eks_role_arn}"
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH

  kubeconfig = <<KUBECONFIG

apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.eks_cluster.endpoint}
    certificate-authority-data: ${aws_eks_cluster.eks_cluster.certificate_authority.0.data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${var.cluster_name}"
KUBECONFIG
}

output "config_map_aws_auth" {
  value = "${local.config_map_aws_auth}"
}

output "kubeconfig" {
  value = "${local.kubeconfig}"
}

output "status" {
  value       = "${aws_eks_cluster.eks_cluster.status }"
  description = "Status of the cluster"
}
output "endpoint" {
  value = "${aws_eks_cluster.eks_cluster.endpoint}"
}

output "eks_sg_id" {
  value = "${aws_eks_cluster.eks_cluster.vpc_config[0]}"
}

output "EKS_Cluster_Name" {
  value       = "${aws_eks_cluster.eks_cluster.id}"
  description = "Name of the EKS Cluster"
}

output "VPC_id" {
  value       = "${aws_eks_cluster.eks_cluster.vpc_config[0].vpc_id }"
  description = "VPC Id used to create the cluster"
}

#output "eks_pub_node_group" {
  #value       = "${aws_eks_node_group.eks_cluster_public_node_group.id}"
  #description = "Worker node Id"
#}

#output "eks_pub_node_group_asg" {
  #value       = "${aws_eks_node_group.eks_cluster_public_node_group.resources[0]}"
  #description = "Worker node asg"
#}

#output "eks_pub_node_group_asg_name" {
 # value       = "${aws_eks_node_group.eks_cluster_public_node_group.resources[1]}"
  #description = "Worker node asg name"
#}

#output "eks_pri_node_group" {
  #value       = "${aws_eks_node_group.eks_cluster_private_node_group.id}"
  #description = "Worker node Id"
#}

#output "eks_pri_node_group_asg" {
  #value       = "${aws_eks_node_group.eks_cluster_private_node_group.resources[0]}"
  #description = "Worker node asg"
#}

#output "eks_pri_node_group_asg_name" {
  #value       = "${aws_eks_node_group.eks_cluster_private_node_group.resources[1]}"
  #description = "Worker node asg name"
#}

 