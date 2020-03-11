# AWS DISCLAMER #
#  __Provided to CLIENT on  # --- 
# The following files are provided by AWS Professional Services describe the process to create an ALB with custom generated certificate rather than using wildcard      certificates.
# These are non-production ready and are to be used for testing purposes.
# These files is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES # OR CONDITIONS OF ANY KIND, either express or implied. See the License 
# for the specific language governing permissions and limitations under the License. # (c) 2019 Amazon Web Services, Inc. or its affiliates.
# All Rights Reserved. # This AWS Content is provided subject to the terms of the AWS Customer Agreement available at # http://aws.amazon.com/agreement or 
# other written agreement between Customer and Amazon Web Services, Inc

#PreReq:
#1. Update DOMAIN_NAME, CSR_NAME, KEY_NAME, CERT_SUBJ vraibles values
#2. Presense of enroll_cert_data_body.json is a must. Place the file in the same directory of this script
#3. Create the file collect_cert_data.crt in the same folder locaiton. This file holds the generated certificate


import boto3
import botocore
import sys
import os
import requests
import time
import itertools
import json

def main():
    
    #Retrieve the VPC_ID of the eks cluster
    vpc_id = "VPC_ID=$(aws ec2 describe-vpcs --filters Name=tag:aws:cloudformation:stack-name,Values=EFX-EKS-CIDR-TST* | jq -r '.Vpcs[].VpcId')"

    print('\033[1m' + "Retriving the VPC id of the cluster")
    os.system(vpc_id)
    os.system("echo $vpc_id")    
        
    
if __name__ == '__main__':
    sys.exit(main())  