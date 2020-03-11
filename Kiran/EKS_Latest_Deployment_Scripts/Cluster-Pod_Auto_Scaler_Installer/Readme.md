Metrics server is installed as this is needed for pod autoscaling.

cluster auto scaler the default K8s component that can be used to perform  scaling nodes in a cluster.
It automatically increases the size of an Auto Scaling group so that pods have a place to run. And it attempts to remove idle nodes, that is, nodes with no running pods.
A Manifest file clusterautocaler.yaml is provided to deploy the CA.

Collect the name of the Auto Scaling Group (ASG) containing your worker nodes. Record the name in clusterautoacaler.yaml

Search for command: and within this block, replace the placeholder text <AUTOSCALING GROUP NAME> with the ASG name that you copied in the previous step. Also, update AWS_REGION value to reflect the region you are using and Save the file.

command:
  - ./cluster-autoscaler
  - --v=4
  - --stderrthreshold=info
  - --cloud-provider=aws
  - --skip-nodes-with-local-storage=false
  - --nodes=2:8:eksctl-EKS-TST-nodegroup-maj-NodeInstanceRole-FOI9M6W6SM7T
env:
  - name: AWS_REGION
    value: us-east-1
This command contains all of the configuration for the Cluster Autoscaler. The primary config is the --nodes flag. This specifies the minimum nodes (2), max nodes (2) and ASG Name.

Although Cluster Autoscaler is the standard for automatic scaling in K8s, it is not part of the main release. We deploy it like any other pod in the kube-system namespace, similar to other management pods.

Please ensure to create cluster_autoscaler.yml file for each autoscaling group.

Please update the cluster autoscaler file names in asg_param.ini file as comma separated values for the property ***cluster_autoscaler_files***

Final step is  to collect the instance profile names of the worker nodes and update the asg.ini ***workernodes_instance_profile_names*** with it. The script will Configure an auto scaling inline policy and add it to the EC2 instance profile of the worker nodes
