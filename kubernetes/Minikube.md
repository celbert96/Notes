# Using Minikube to Create a Cluster

## Cluster Basics
- K8s coordinates a highly available cluster of computers that are connected to work as a single unit. 
- K8s automates the distribution and scheduling of application containers across the cluster

A cluster contains two types of resources:
1. **Control Plane** - Responsible for managing the cluster
    - Schedules applications
    - Maintains application desired state
    - Scales applications
    - Rolls out new updates
2. **Nodes** - Workers (VMs or physical computers) that run applications
    - Each node has a **kubelet** - an agent for managing the node and communicating with the K8s control plane
    - Each node should have tools for handling container operations, such as **containerd** or **CRI-O**


When you deploy applications on K8s, you tell the control plane to start the application containers. The control plane schedules containers to run on the cluster's nodes. Node level components, such as the kublet, communicate with the control plane using the **Kubernete's API**


## Minikube Commands

### Create a minikube cluster
```minikube start```

### Open the Dashboard
```minikube dashboard```

> The dashboard command enables the dashboard add-on and opens the proxy in the default web browser. You can create Kubernetes resources on the dashboard such as Deployment and Service.

> By default, the dashboard is only accessible from within the internal Kubernetes virtual network. The dashboard command creates a temporary proxy to make the dashboard accessible from outside the Kubernetes virtual network.

> To stop the proxy, run Ctrl+C to exit the process. After the command exits, the dashboard remains running in the Kubernetes cluster. You can run the dashboard command again to create another proxy to access the dashboard.

### Create a Deployment
A Kubernetes **Pod** is a group of one or more Containers, tied together for the purposes of administration and networking 

A Kubernetes **Deployment** checks on the health of your pod and restarts the pod's container if it terminates. Deployments are the recommended way to manage the creation and scaling of pods

1. Use the `kubectl create` command to create a Deployment that manages a Pod. The Pod runs a container based on the provided Docker image

    ```
    # Run a test container image that includes a webserver
    kubectl create deployment hello-node --image=registry.k8s.io/e2e-test-images/agnhost:2.39 -- /agnhost netexec --http-port=8080
    ```

2. View the Deployment

    `kubectl get deployments`

    The output is similar to
    ```
    NAME         READY   UP-TO-DATE   AVAILABLE   AGE
    hello-node   1/1     1            1           1m
    ```

3. View the Pod

    `kubectl get pods`

    The output is similar to
    ```
    NAME                          READY     STATUS    RESTARTS   AGE
    hello-node-5f76cf6ccf-br9b5   1/1       Running   0          1m
    ```

4. View cluster events

    `kubectl get events`

5. View the kubectl configuration

    `kubectl view config`

6. View application logs for a container in a pod (replace pod name with the one you got from kubectl get pods)

    > **Note**: Replace hello-node-5f76cf6ccf-br9b5 in the kubectl logs command with the name of the pod from the kubectl get pods command output.

    `kubectl logs hello-node-5f76cf6ccf-br9b5`

    The output is similar to
    ```
    I0911 09:19:26.677397       1 log.go:195 Started HTTP server on port 8080
    I0911 09:19:26.677586       1 log.go:195 Started UDP server on port  8081
    ```

> **Note**: For more information about kubectl commands, see the kubectl overview.