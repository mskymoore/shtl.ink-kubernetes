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
2. Follow [this guide](https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html) to create an iam oidc provider for the cluster.
3. Follow [this guide](https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html) to deploy the aws load balancer controller into the cluster.
4. Populate ```0300_shtl-ink_secrets.yml``` with the following
   ```bash
   # without the -n a \n character is on the end of every secret, which jacks things up.
   echo -n 'SOMESECRET' | base64
   # copy the output and put it on the appropriate line in 0300_shtl-ink_secrets.yml
   ```
5. Deploy the project
   ```bash
   ./stack.sh create
   ```
6. If a CNAME is needed on the root domain
   - configure ```900_shtl-ink-ddns_secrets.yml``` and ```901_shtl-ink-ddns_deployment.yml```.
   - Deploy the ddns
      ```bash
      ./ddns.sh create
      ```
---
## Remove from a cluster
1. Remove the project
   ```bash
   ./ddns.sh delete
   ./stack.sh delete
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