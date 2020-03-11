Calico enables networking and network policy in Kubernetes clusters. Calico provides the following advantages when running in Amazon Web Services (AWS):
•	Network Policy for Containers: Calico provides fine-grained network security policy for individual containers.
•	No Overlays: Within each VPC subnet Calico doesn’t need an overlay, which means high performance networking for your containers.

Installing Calico-

Apply the Calico manifest from the aws/amazon-vpc-cni-k8s GitHub project. This    creates the daemon sets in the kube-system namespace.

•	kubectl apply -f https://raw.githubusercontent.com/aws/amazon-vpc-cni-k8s/release-1.5/config/v1.5/calico.yaml

Watch the kube-system DaemonSets and wait for the calico-node DaemonSet to have the DESIRED number of pods in the READY state.
When this happens, Calico is working

kubectl get daemonset calico-node --namespace kube-system
Output:

NAME          DESIRED   CURRENT   READY     UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
calico-node   3         3         3         3            3           <none>          38s

Example :-

Below Network policies allow pods in tenantthreenamespace to receive calls
only  from pods in tenanttwonamespace.
--
kind: NetworkPolicy
apiVersion: extensions/v1beta1
metadata:
  namespace: tenantthreenamespace
  name: allow-tenanttwonamespace
spec:
  podSelector:
    matchLabels:
      app: tenantthreeapp
  ingress:
    - from:
        - namespaceSelector:
            matchLabels:
              role: tenanttwonamespace

--
kind: NetworkPolicy
apiVersion: extensions/v1beta1
metadata:
  namespace: tenantthreenamespace
  name: allow-tenanttwonamespace-pod
spec:
  podSelector:
    matchLabels:
      app: tenantthreeapp
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: app
      ports:
        - protocol: TCP
          port: 8080


Further info can be found under https://docs.projectcalico.org/v3.7/reference/public-cloud/aws
