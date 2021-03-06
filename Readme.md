# shtl.ink kubernetes
## Prepare
1. install kubectl and eksctl
   ```bash
   brew install kubectl eksctl
   ```
---
## Deploy to a cluster

1. Configure kubectl
   ```bash
   aws eks --region $AWS_REGION update-kubeconfig --name $CLUSTER_NAME
   ```
2. Populate ```0300_shtl-ink_secrets.yml``` with the following
   ```bash
   # without the -n a \n character is on the end of every secret, which jacks things up.
   echo -n 'SOMESECRET' | base64
   # copy the output and put it on the appropriate line in 0300_shtl-ink_secrets.yml
   ```
3. Deploy the project
   ```bash
   ./stack.sh create shtl-ink
   ```
---
## Remove from a cluster
1. Remove the project
   ```bash
   ./stack delete ddns
   ./stack delete shtl-ink
   ```
---

## Add admin user to cluster
1. As a user with admin privileges to the cluster run the following to add the new admin user to the configmap.
   ```bash
   kubectl edit -n kube-system configmap/aws-auth
   ```
2. Add the desired user to the config...
   ```yaml
   ---
   apiVersion: v1
   data:
      ...
      mapUsers: |
         - userarn: arn:aws:iam::ACCOUNTID:user/USERNAME
           username: USERNAME
           groups:
            - system:masters
   ...
   ```
3. Finally, still as a user with admin privileges to the cluster, create a role binding on the cluster for the user specified in the configmap.
   ```bash
   kubectl create clusterrolebinding $USERNAME-cluster-admin-binding --clusterrole=cluster-admin --user=$USERNAME
   ```