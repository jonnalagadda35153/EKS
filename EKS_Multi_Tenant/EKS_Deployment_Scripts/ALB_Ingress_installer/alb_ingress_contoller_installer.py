import boto3
import configparser
import sys
import os
import time

config = configparser.ConfigParser()
config.read('ingress_param.ini')

workernode_role_names = str(config['alb']['workernodes_instance_role_name'])
workernode_role = workernode_role_names.split(",")

#Attaching IAM policy for ALB ingress controller
for i in range(0,len(workernode_role)):
    print("\n")
    attach_policy = 'aws iam put-role-policy --role-name '+ str(workernode_role[i]) +' --policy-name ALB_Ingress_policy --policy-document file://alb_ingress_IAM_policy.json'
    os.system(attach_policy)
    print('Attached Policy to the worker nodes with role name '+str(workernode_role[i]))
    time.sleep(3)

#Applying RBAC in the Kube-system namespace to enable ALB Creation and Communication
print("\n")
apply_rbac = 'kubectl apply -f RBAC.yaml'
print("Applying RBAC")
print(apply_rbac)
os.system(apply_rbac)
time.sleep(2)

#Installing  alb-ingress-controller
#Please update Cluster Name and VPC id and Resgion in the alb-ingress-controller.yml
print("\n")
apply_ingress = 'kubectl apply -f alb-ingress-controller.yaml'
print(apply_ingress)
os.system(apply_ingress)