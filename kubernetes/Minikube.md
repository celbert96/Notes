# Using Minikube to Create a Cluster

### Cluster Basics
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





