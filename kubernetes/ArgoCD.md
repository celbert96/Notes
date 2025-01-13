# Argo CD for Bronzebot

## Argo Initial Setup

### Install
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### Port Forward
```
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

### Get Admin Password
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

## Application Setup

### Create helm chart in new repo
```
helm create {application-name}
```

### Update templates directory
```
rm -rf {appname}/templates
mkdir {appname}/templates
cd {appname}/templates
touch namespace.yaml
touch deployement.yaml
...
```

### Publish Chart Repo to GitHub
```
you know how...

for this I just left the repo public so Argo could access it
```

### Add Appliction to ArgoCD via UI




