import boto3, json
import configparser
import os
#import yaml
#Update role_name, policy_name, account_number in the iam.ini file before executing the python script

iam = boto3.client('iam')

config = configparser.ConfigParser()
config.read('tenant.ini')
role_name = str(config['iam']['role_name'])
policy_name = str(config['iam']['policy_name'])
account_id = boto3.client('sts').get_caller_identity().get('Account')
#account_id = str(config['iam']['account_id'])
eks_cluster = str(config['iam']['eks_cluster_name'])
region = str(config['iam']['region'])
user = str(config['iam']['user'])


#Creating and Attaching IAM role to the user account
print("Creating a Role")
path = '/'
description = "Role to be attached to a namespace"
trust_policy = {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::"+account_id+":root"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
try:
    response = iam.create_role(
        Path=path,
        RoleName=role_name,
        AssumeRolePolicyDocument=json.dumps(trust_policy),
        Description=description,
        MaxSessionDuration=3600
    )
    print(response)
    print("IAM Role Created with ARN -> arn:aws:iam::"+str(account_id)+":role/"+role_name)
    print("Please copy the role name, the same will be used in deployemnt automation")
except Exception as e:
    print(e)

#Creating and attaching the custom policy to the user
print("\n")
print("Creating IAM Policy to be attached to the Role")
creating_policy = "aws iam create-policy --policy-name " + policy_name +" --policy-document file://IAM_tenant_policy.json"
print(creating_policy)
os.system(creating_policy)
print("Policy is created with arn -> arn:aws:iam::"+str(account_id)+":policy/"+policy_name)
print("\n")
print("Attaching Policy to the role")
attach_policy = "aws iam attach-role-policy --role-name "+role_name+" --policy-arn arn:aws:iam::"+str(account_id)+":policy/"+policy_name
os.system(attach_policy)
print(attach_policy)
print("Attached Policy to the Role")

print("\n")
#Create role and rolebinding for the tenant
tenant_rbac = "kubectl apply -f Tenant_RBAC.yaml"
print("Applying Role and RoleBinding to the cluster")
print(tenant_rbac)
os.system(tenant_rbac)

print("\n")
#Updating AWS EKS Auth with the new role and attaching it to the service account.
print("Updating configmap/aws-auth with the new Role")
eks_aws_auth_update = "eksctl create iamidentitymapping --name "+ eks_cluster+" --role arn:aws:iam::"+str(account_id)+":role/"+role_name+" --group None --username "+user 
print(eks_aws_auth_update)
os.system(eks_aws_auth_update)
print("Attached the role to aws-auth configmap")

'''
#Uncomment this portion of the script to update kubeconfig

#Update AWS EKS Kubeconfig with the role
print("Updating EKS kubeconfig with the new role")
update_kubeconfig = "aws eks update-kubeconfig --name "+ eks_cluster +" --region "+ region +" --role-arn arn:aws:iam::"+str(account_id)+":role/"+role_name
os.system(update_kubeconfig)
print("Updated kubeconfig with new role")
'''