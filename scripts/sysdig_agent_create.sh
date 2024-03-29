###########################################################################################
##  Script to deploy sysdig agents to all cluster nodes (masters/infra/worker/support/etc)
##  NOTE: To be run on OCP Master
###########################################################################################

oc adm new-project sysdig-agent --node-selector='app=sysdig-agent'
oc label node --all "app=sysdig-agent"
oc project sysdig-agent
oc create serviceaccount sysdig-agent
oc adm policy add-scc-to-user privileged -n sysdig-agent -z sysdig-agent
oc adm policy add-cluster-role-to-user cluster-reader -n sysdig-agent -z sysdig-agent
