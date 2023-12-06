#!/bin/bash
#


#https://github.com/techiescamp/kubeadm-scripts

# RedHat

# disable swap
sudo swapoff -a
(crontab -l 2>/dev/null; echo "@reboot /sbin/swapoff -a") | crontab - || true

sudo yum update -y

# container runtime 
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system

lsmod | grep br_netfilter
lsmod | grep overlay

sysctl net.bridge.bridge-nf-call-iptables net.bridge.bridge-nf-call-ip6tables net.ipv4.ip_forward

# Set SELinux in permissive mode (effectively disabling it)
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

# Install containerd

sudo yum update 
sudo yum install -y containerd
echo "containerd runtime installed susccessfully"

# Create a containerd configuration file
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml


# Install kubelet, kubectl and Kubeadm

sudo yum install -y ca-certificates curl

# This overwrites any existing configuration in /etc/yum.repos.d/kubernetes.repo
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/repodata/repomd.xml.key
exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
EOF

sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
sudo systemctl enable --now kubelet


sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://dl.k8s.io/apt/doc/apt-key.gpg




###################################################################
    1  sudo modprobe overlay
    2  sudo modprobe br_netfilter
    3  cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
    4  overlay
    5  br_netfilter
    6  EOF
    7  cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
    8  net.bridge.bridge-nf-call-iptables = 1
    9  net.ipv4.ip_forward = 1
   10  net.bridge.bridge-nf-call-ip6tables = 1
   11  EOF
   12  sudo sysctl –system
   13  sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
   14  sudo dnf update
   15  sudo dnf install -y containerd
   16  sudo mkdir -p /etc/containerd
   17  sudo containerd config default | sudo tee /etc/containerd/config.toml
   18  sudo vi /etc/containerd/config.toml 
   19  sudo systemctl restart containerd
   20  ps -ef | grep containerd
   21  sudo dnf install curl
   22  cat < /etc/yum.repos.d/kubernetes.repo
   23  [kubernetes]
   24  name=Kubernetes
   25  baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
   26  enabled=1
   27  gpgcheck=1
   28  repo_gpgcheck=1
   29  gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
   30  EOF
   31  vi /etc/yum.repos.d/kubernetes.repo
   32  sudo dnf update
   33  sudo dnf install -y kubelet kubeadm kubectl
   34  sudo hostnamectl set-hostname "master-node"
   35  exec bash
   36  sudo swapoff –a
   37  curl https://raw.githubusercontent.com/projectcalico/calico/v3.26.4/manifests/calico.yaml -O
   38  ll
   39  sudo kubectl apply -f calico.yaml
   40  sudo kubeadm init
   41  systemctl enable kubelet.service
   42  ip a
   43  echo "master-node" >> /etc/hosts 
   44  sudo kubeadm init
   45  ping master-node
   46  cat /etc/hosts
   47  vi /etc/hosts
   48  ping master-node
   49  sudo kubeadm init
   50  nslookup master-node
   51  vi /proc/sys/net/ipv4/ip_forward
   52  history 
