# shtl.ink kubernetes

## Deploy to a cluster

1. Configure kubectl
   ```bash
   aws eks --region $AWS_REGION update-kubeconfig --name $CLUSTER_NAME
   ```
2. Deploy the project
   ```bash
   kubectl apply -f shtl-ink_namespace.yml
   kubectl apply -f shtl-ink_storage_classes.yml
   # fill each key in this file with `echo -n 'mysecretvalue' | base64`
   kubectl apply -f shtl-ink_secrets.yml
   kubectl apply -f shtl-ink-db_deployment.yml
   kubectl apply -f shtl-ink-db_service.yml
   kubectl apply -f shtl-ink_depoyment.yml
   kubectl apply -f shtl-ink-api_service_aws.yml
   kubeclt apply -f shtl-ink_service_aws.yml
   ```
---
## Add user to admin cluster
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