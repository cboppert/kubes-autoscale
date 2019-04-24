# Kubernetes Autoscaler

## The Guide
Follows guide here - https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/

### Start deployment running image, expose as service
```bash
  $ kubectl run php-apache --image=k8s.gcr.io/hpa-example --requests=cpu=200m --expose --port=80
  service "php-apache" created
  deployment.apps "php-apache" created
```


