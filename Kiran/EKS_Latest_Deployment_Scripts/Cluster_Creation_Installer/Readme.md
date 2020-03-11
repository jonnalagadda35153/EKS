#### Automation Script leverages eksctl to create EKS cluster. It is a simple CLI tool for creating clusters on EKS . It is written in Go, uses CloudFormation. Please refer to eksctl.io for further info. A sample eksclutercreation.yaml is attached for reference.
#### Python ***eksclusterinstaller.py*** to create the cluster.
#### update kubectl_curl and IAM_auth_download with the right URL based on the EKS version in eksclusterinstaller.py (https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html,
  https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html)
#### Please ensure to update  the eksclutercreation.yaml with appropriate vpc ids, Subnets and other tags before running the script.
### If you would like the script to create new VPC, subnets. Please invoke the script with newvpc as the argument.
