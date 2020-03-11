output "eks_role_arn" {
  value       = aws_iam_role.eks_role.arn
  description = "ARN of the EKS IAM role."
}

output "eks_worker_role_arn" {
  value       = aws_iam_role.eks_worker_role.arn
  description = "ARN of the EKS Wroker nodes IAM role"
}