# openshift-sysdig
If you are using Red Hat OpenShift, these steps are required. They describe how to create a project, assign and label the node selector, create a privileged service account, and add it to a cluster role. 

Configure for OpenShift 
If you are using Red Hat OpenShift, these steps are required. They describe how to create a project, assign and label the node selector, create a privileged service account, and add it to a cluster role. 

Copy/Paste Sample Code Block 
In the example code, this document uses  sysdig-agent for the PROJECT NAME (-n),  the SERVICE ACCOUNT (-z), and the NODE SELECTOR.

You can copy-paste the code as-is, or follow the steps below to customize your naming conventions.

oc adm new-project sysdig-agent --node-selector='app=sysdig-agent'
oc label node --all "app=sysdig-agent"
oc project sysdig-agent
oc create serviceaccount sysdig-agent
oc adm policy add-scc-to-user privileged -n sysdig-agent -z sysdig-agent
oc adm policy add-cluster-role-to-user cluster-reader -n sysdig-agent -z sysdig-agent

Create a secret key using the command: 

kubectl create secret generic sysdig-agent --from-literal=access-key=<your sysdig access key> -n sysdig-agent
  
If you created a service account name other than sysdig-agent: Edit sysdig-agent-daemonset-v2.yaml to provide your custom value:

serviceAccount: sysdig-agent
FOR ON-PREM INSTALLATIONS ONLY: Edit configmap.yaml to add the collectoraddress and port, and SSL/TLS information :

collector:
collector_port: 443
ssl: #true or false
ssl_verify_certificate: #true or false
ssl_verify_certificate should be set to false if a self-signed certificate or private, CA-signed cert is used.  See information about SSL in on-premises here. 

(ALL INSTALLS): Apply the configmap.yaml file using the command: 

kubectl apply -f sysdig-agent-configmap.yaml -n sysdig-agent


(ALL INSTALLS): Apply the daemonset-v2.yaml file using the command: 


kubectl apply -f sysdig-agent-daemonset-v2.yaml -n sysdig-agent
