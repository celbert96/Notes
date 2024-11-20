# Helm

## Intro
### What is Helm?
- Helm is the package management system for Kubernetes
- Allows you to:
  - Install applications into the cluster with one command
  - Create chart versions
  - Upgrade versions
  - Debug deployments
  - Rollback as needed

### Helm Hub
- https://artifacthub.io/
- Hosts charts you can install via helm

## Install and Configure a Chart from Helm Hub

### Install kube-state-metrics via helm
- Add the repo
  ```
  helm repo add bitnami https://charts.bitnami.com/bitnami
  ```
- Make sure we have access to latest charts
  ```
  helm repo update
  ```
- Verify repo properly installed
  ```
  helm repo list
  ```
- Install the kube-state-metrics app into the cluster (namespace metrics)
  ```
  helm install kube-state-metrics bitnami/kube-state-metrics -n metrics
  ```
- Check on deployment of chart in the `metrics` namespace
  ```
  helm ls -n metrics
  ```

### Inspect a chart in your Kubernetes cluster
- View chart info
  ```
  helm show chart bitnami/kube-state-metrics
  ```

- View helm values file
  ```
  helm show values bitnami/kube-state-metrics
  ```
  
### Update a Helm Chart
- Can see the helm chart version and app version in the output of `helm ls`
- Upgrade command
  ```
  helm upgrade kube-state-metrics bitnami/kube-state-metrics --version {version} -n metrics
  ```

## Deploy an Application Using Helm

### Create a new Helm Chart from the Command Line
- Create a helm chart
  ```
  helm create {chart-name}
  ```
  
### Deploy and Update a Kubernetes ConfigMap via Helm
- A kubernetes ConfigMap is a K8s object that stores non-sensitive info used by pods
- Create a chart using `helm create` then remove all files in the `templates` directory
- In the now empty `templates` dir, add a new file `cm.yaml`
- Update `cm.yaml` with the following:
  ```
  apiVersion: v1
  kind: ConfigMap
  metadata:
    name: first-chart-configmap
  data:
    port: "8080"
    allowTesting: "true"
  ```
- Install the chart
  ```
  helm install {chartName} .
  ```
- After making a change, you can upgrade the chart
  ```
  helm upgrade {chartName} .
  ```
  
### Deploy and Update a Kubernetes Secret via Helm
- To encode a string as base64, run `echo -n 'string' | base64`
- Add a `secrets.yaml` file to the templates directory
  ```
  apiVersion: v1
  kind: Secret
  metadata:
    name: first-secret
  type: Opaque
  data:
    username: {base64 encoded string}
    password: {base64 encoded string}
  ```

### Rollback a Helm Release
- View all revisions of a chart:
  ```
  helm history {chartName}
  ```

- Rollback to the most recent previous chart version
  ```
  helm rollback {chartName}
  ```

- Rollback to a specific revision
  ```
  helm rollback {chartName} {revisionNumber}
  ```
  
## Advanced Features

### Dynamically Render a Value with a Helm Conditional Statement
- Conditionals use the following format:
  ```
  {{if}}
  {{else}}
  {{end}}
  ```
- Example:
  ```
  {{if eq .Values.env "staging"}}
  paramKey: "true"
  {{else}}
  paramKey: "false"
  {{end}}
  ```