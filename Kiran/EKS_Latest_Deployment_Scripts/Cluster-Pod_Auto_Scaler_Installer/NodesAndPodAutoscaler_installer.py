import boto3
import configparser
import sys
import os
#Metrics server is used for Pod autoscaling
metricserver_install = 'helm install stable/metrics-server --name metrics-server --version 2.0.4 --namespace metrics'
os.system(metricserver_install)

#From here on , the code automates worker node autoscaling
client = boto3.client('autoscaling')

config = configparser.ConfigParser()
config.read('asg_param.ini')



workernode_role_names = str(config['asg']['workernodes_instance_profile_names'])
workernode_role = workernode_role_names.split(",")
cluster_autoscaler_files = config['asg']['cluster_autoscaler_files']
cluster_autoscaler_file = cluster_autoscaler_files.split(",")

#Attaching IAM Role to enable Auto Scaling
for i in range(0,len(workernode_role)):
    attach_policy = 'aws iam put-role-policy --role-name '+ str(workernode_role[i]) +' --policy-name ASG-Policy-For-Worker-Nodes --policy-document file://k8_clusterscalingpolicy.json'
    os.system(attach_policy)
    print('Attached Policy to the worker nodes with role name '+str(workernode_role[i]))

#Cluster AutoScaling
cluster_autoscaler_files = config['asg']['cluster_autoscaler_files']
cluster_autoscaler_file = cluster_autoscaler_files.split(",")
for i in range(0,len(cluster_autoscaler_file)):
    print('Cluster Autoscling with the configuration: '+ cluster_autoscaler_file[i] )
    os.system('kubectl apply -f '+ cluster_autoscaler_file[i] )
