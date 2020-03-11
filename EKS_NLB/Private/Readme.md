### Follow the steps to use Nginx NLB with ingress to expose applications

1. Run the aws_nlb_resources.yaml script to create necessary Roles and Rolebindings to successfully 
create the AWS NLB.
  command: kubectl apply -f aws_nlb_resources.yaml

2. Depending on to have ALB internal (or) Internet-facing 
  Add the tag `service.beta.kubernetes.io/aws-load-balancer-internal: "true"` under annotations to create inernal NLB
  Remove the tag to have internet-facing Loadbalancer.
  Now run the script with the command: kubectl apply -f aws_nlb_resources.yaml

### With the execution of the command we can go to the console and see a new NLB coming up.
# Copy the DNS name to clipboard.

3. Open the sample_app_nlb.yaml and update the host with the AWS NLB DNS under ingress section. 
  Now create the app with the command: kubectl apply -f sample_app_nlb.yaml
 
Now you should be able to reach the application from browser with the DNS name 
eg: ad7ba6c27491c11ea82740ee48bd3fe7-eafd4f65c6d9c381.elb.us-east-1.amazonaws.com/ping 

4. To reach to an application running on a differnent namespace create an ingress in that namespace as shown below

          apiVersion: extensions/v1beta1
          kind: Ingress
          metadata:
            name: api-ingresse-test
            namespace: <namespace>
            annotations:
              kubernetes.io/ingress.class: "nginx"
          spec:
            rules:
            - host: ad7ba6c27491c11ea82740ee48bd3fe7-eafd4f65c6d9c381.elb.us-east-1.amazonaws.com
              http:
                paths:
                  - path: /ping
                    backend:
                      serviceName: <service name>
                      servicePort: <application port>

    With this we shoule be able to use one NLB for applications that are running across namespaces
                  