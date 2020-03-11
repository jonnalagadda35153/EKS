import boto3
import configparser
import sys
import os


client = boto3.client('autoscaling', region_name='us-west-2')

config = configparser.ConfigParser()
config.read('asg_param.ini')

autoscaling_group_names = str(config['asg']['cluster_autoscaler_files'])
autoscaling_group_name = autoscaling_group_names.split(",")

workernode_role_names = str(config['asg']['workernodes_instance_profile_names'])
workernode_role = workernode_role_names.split(",")
cluster_autoscaler_files = config['asg']['cluster_autoscaler_files']
cluster_autoscaler_file = cluster_autoscaler_files.split(",")

#Attaching IAM Role to enable Auto Scaling    
for i in range(0,len(workernode_role)):
    attach_policy = 'aws iam put-role-policy --role-name '+ str(workernode_role[i]) +' --policy-name ASG-Policy-For-Worker-Nodes --policy-document file://~/environment/EKS_Deployment_Scripts/Cluster_Auto_Scaling_Installer/k8_clusterscalingpolicy.json'
    os.system(attach_policy)
    print(attach_policy)
    print('Attached Policy to the worker nodes with role name '+str(workernode_role[i]))
    print("\n")
  
#Cluster AutoScaling  
cluster_autoscaler_files = config['asg']['cluster_autoscaler_files']
cluster_autoscaler_file = cluster_autoscaler_files.split(",")
for i in range(0,len(cluster_autoscaler_file)):
    print("\n")
    print('Cluster Autoscling with the configuration: '+ cluster_autoscaler_file[i] )
    asg = "kubectl apply -f "+cluster_autoscaler_file[i]
    print(asg)
    os.system('kubectl apply -f '+ cluster_autoscaler_file[i] )    