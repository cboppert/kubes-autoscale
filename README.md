# Kubernetes Autoscaler

## The Guide
Follows guide here - https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/

### Start deployment running image, expose as service
```bash
  $ kubectl run php-apache --image=k8s.gcr.io/hpa-example --requests=cpu=200m --expose --port=80
  service "php-apache" created
  deployment.apps "php-apache" created
```

### Create horizontal pod autoscaler
Maintains CPU utilization at around 50% and runs between 1 and 10 instances
```bash
  $ kubectl autoscale deployment php-apache --cpu-percent=50 --min=! --max=10
  deployment.apps "php-apach" autoscaled

  $ kubectl get hpa
  NAME         REFERENCE                     TARGET     MINPODS     MAXPODS    REPLICAS   AGE
  php-apache   Deployment/php-apache/scale   0% / 50%   1           10         1          18s
```

### Increase Load
Run in different terminal. Creates container, sends infinite loop of queries to service
```bash
  $ kubectl run -i --tty load-generator --image=busybox /bin/sh
  If you don't see a command  prompt, try pressing enter.
  / # while true; do wget -q -O- http://php-apache.default.svc.cluster.local; done
  OK!OK!....
```
In another terminal see the CPU load with
```bash
  $ kubectl get hpa
  NAME        REFERENCE                     TARGET      MINPODS    MAXPODS    REPLICAS    AGE
  php-apache  Deployment/php-apache         383%/50%    1          10         3           13m
```
See the deployment status with
```bash
  kubectl get deployment php-apache
  NAME        DESIRED       CURRENT     UP-TO-DATE    AVAILABLE    AGE
  php-apache  3             3           3             3            28m
```

### Stop Load
Kill busybox with <Ctrl-C> and check hpa
```bash
  $ kubectl get hpa
  NAME       REFERENCE             TARGET      MINPODS      MAXPODS     REPLICAS     AGE
  php-apache Deployment/php-apache 120%/50%    1            10          6            19m

  $ kubectl get hpa
  NAME       REFERENCE             TARGET      MINPODS      MAXPODS     REPLICAS     AGE
  php-apache Deployment/php-apache 87%/50%     1            10          6            19m

  $ kubectl get hpa
  NAME       REFERENCE             TARGET      MINPODS      MAXPODS     REPLICAS     AGE
  php-apache Deployment/php-apache 120%/50%    1            10          6            19m

  $ kubectl get hpa
  NAME       REFERENCE             TARGET      MINPODS      MAXPODS     REPLICAS     AGE
  php-apache Deployment/php-apache 120%/50%    1            10          1            4h
```

## Future Exploration

### kubectl run

### kubectl autoscale deployment

### kubectl get hpa
