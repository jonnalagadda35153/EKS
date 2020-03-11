Tenant Isolation is achieved through namespaces. 
This script creates an IAM role for authentication and  a RBAC role to 
scope the API calls allowed. 
The IAM role is mapped to the useraccount in aws-auth and kube-config file

Please ensure the following prerequisites are achieved before running the script

1) Namespace should exist for the tenant.
2) Update the tenant_RBAC.yaml file with  the  namespace,username(tenant useraccount) and role name. 
3) Update the RABC rules in tenant_RBAC.yaml as needed by the tenant application.
3) Update the account_id property in tenant.ini file with the account number of the tenant