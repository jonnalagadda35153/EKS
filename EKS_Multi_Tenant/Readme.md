# EKS Cluster Creation Automation

1. Cluster Creation
2. Auto Scaling Installer
3. Enabling ALB Ingress Controller

## Create Cloud 9 Env.
1. Create Cloud 9 env
2. Attach EKS Admin role to the environment through the console
## Cluster Creation
1. Navigate to **Cluster_Creation_Installer** folder
2. To create the cluster in **existing VPC**
* Update the ***eksClusterCreation.yml*** with VPC and subnet Id's
```bash
python eksclusterinstaller.py
```
3. To create a cluster with a new VPC
```bash
python eksclusterinstaller.py newvpc
```
## AutoScaling Cluster
1. Navigate to **Cluster_Auto_Scaling_Installer** folder
2. Update ***cluster_autoscaler.yml*** 
* Update AutoScalingGroup, Min & Max nodes
3. Update **asg_param.ini** with Node Group, AutoScalingGroup, Min & Max nodes
4. Run the command to enable autoscaling
```bash
python eksclusterautoscale_installer.py
```
## ALB Ingress Controller Installer
1. Navigate to ALB_Ingress_installer
2. Update **alb-ingress-controller.yaml** with Cluster name, VPC id, region
3. Update **ingress_param.ini** with worker nodes instance profile
4. Run the command to install alb ingress controller
```bash
python alb_ingress_contoller_installer.py
```
## Sample Application Deployment

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.0.0/docs/examples/2048/2048-namespace.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.0.0/docs/examples/2048/2048-deployment.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.0.0/docs/examples/2048/2048-service.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.0.0/docs/examples/2048/2048-ingress.yaml

```
## Verify ingress contoller deployment
```
kubectl get ingress/2048-ingress -n 2048-game
```
