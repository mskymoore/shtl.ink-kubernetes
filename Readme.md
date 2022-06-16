1. Start minikube
   ```bash
   minikube start
   minikube dashboard
   ```
2. Start a minikube tunnel
   ```bash
   # new terminal
   minikube tunnel
   ```
3. Mount frontend config to minikube
   ```bash
   # minikube can only mount directories
   minikube mount config:/opt/config
   ```
4. Apply the deployment
   ```bash
   # new terminal
   kubectl apply -f shtl-ink-api_deployment.yml
   ```
5. Apply the service
   ```bash
   kubectl apply -f shtl-ink-api_service.yml
   ```
6. Check in browser
   1. navigate to http://localhost:8000/docs
   2. navigate to http://localhost:3000

7. View startup logs
    ```bash
    kubectl logs $POD_NAME -c $CONTAINER_NAME --tail 100 --follow
    ```