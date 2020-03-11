output "eks_cluster_sg" {
  value       = "EKS Master Security Group id: ${aws_security_group.eks_security_group.id}"
  description = "EKS master security group id"
}

output "eks_cluster_worker_sg" {
  value       = "EKS Worker Node Security Group id: ${aws_security_group.eks_worker_security_group.id}"
  description = "EKS Worker nodes security group id"
}