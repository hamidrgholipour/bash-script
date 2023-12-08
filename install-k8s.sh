#!/bin/bash

####################################
#########install k8s Redhat#########
####################################

sudo modprobe overlay
sudo modprobe br_netfilter
#sudo swapoff –a

cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

cat <<EOF | sudo tee /proc/sys/net/ipv4/ip_forward
1
EOF

#sudo sysctl –system
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf update
sudo dnf install -y containerd
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
#sudo vi /etc/containerd/config.toml 
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml 
sudo systemctl restart containerd
ps -ef | grep containerd
sudo dnf install -y iproute-tc


cat <<EOF | sudo tee  /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF



sudo dnf update -y
sudo dnf install -y kubelet kubeadm kubectl
sudo systemctl enable kubelet.service


#sudo hostnamectl set-hostname "master"
# cat <<EOF | sudo tee -a /etc/hosts
# "$(hostname -I) master"
# EOF
#sudo bash -c 'echo "$(hostname -I) master" >> /etc/hosts'

## for master node 
#sudo kubeadm init
#kubeadm init --ignore-preflight-errors=all
#kubeadm token create --print-join-command
##k8s config file : export KUBECONFIG=/etc/kubernetes/admin.conf
#curl https://raw.githubusercontent.com/projectcalico/calico/v3.26.4/manifests/calico.yaml -O
#sudo kubectl apply -f calico.yaml
