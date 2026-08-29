# Kubernetes Cheat Sheet

## Pods
- `kubectl get pods -n <namespace>`
- `kubectl describe pod <pod-name> -n <namespace>`
- `kubectl logs <pod-name> -n <namespace>`
- `kubectl logs <pod-name> -n <namespace> --previous` (for crashed pods)

## Deployments
- `kubectl get deploy -n <namespace>`
- `kubectl rollout status deploy/<name> -n <namespace>`
- `kubectl rollout history deploy/<name> -n <namespace>`

## Services & Network
- `kubectl get svc -n <namespace>`
- `kubectl get endpoints -n <namespace>`
- `kubectl get ingress -n <namespace>`

## Nodes & Cluster
- `kubectl get nodes`
- `kubectl top nodes`
- `kubectl top pods -n <namespace>`
