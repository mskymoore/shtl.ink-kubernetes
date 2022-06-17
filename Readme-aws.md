1. Configure kubectl
   ```bash
   aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
   ```
2. Deploy the project
   ```bash
   kubectl apply -f namespace_deployment.yml
   kubectl apply -f shtl-ink-db_deployment.yml
   kubectl apply -f shtl-ink-db_service.yml
   kubectl apply -f shtl-ink_depoyment.yml
   kubectl apply -f shtl-ink-api_service_aws.yml
   kubeclt apply -f shtl-ink_service_aws.yml
   ```