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