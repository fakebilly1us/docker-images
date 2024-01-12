#!/usr/bin/env bash
set -ex

cat >>/etc/sysctl.conf <<'EOF'
net.ipv4.ip_forward = 1
vm.max_map_count = 262144
EOF
sysctl -p
systemctl restart network

yum remove docker \
           docker-client \
           docker-client-latest \
           docker-common \
           docker-latest \
           docker-latest-logrotate \
           docker-logrotate \
           docker-engine

yum install -y yum-utils device-mapper-persistent-data lvm2

yum-config-manager --add-repo http://download.docker.com/linux/centos/docker-ce.repo

yum install -y docker-ce-24.0.6-1.el7 docker-ce-cli-24.0.6-1.el7 containerd.io docker-buildx-plugin docker-compose-plugin

systemctl start docker
systemctl enable docker

cat >>/etc/sysctl.conf <<'EOF'
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-arptables = 1
EOF
