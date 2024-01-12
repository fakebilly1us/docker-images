#!/usr/bin/env bash
set -ex

cat >>/etc/sysctl.conf <<'EOF'
net.ipv4.ip_forward = 1
vm.max_map_count = 262144
EOF
sysctl -p

(for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do apt-get remove $pkg; done) || true
(apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras) || true
(rm -rf /var/lib/docker && rm -rf /var/lib/containerd) || true

# Add Docker's official GPG key:
apt-get update
apt-get install -y ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce=5:24.0.6-1~debian.12~bookworm docker-ce-cli=5:24.0.6-1~debian.12~bookworm containerd.io docker-buildx-plugin docker-compose-plugin

cat >>/etc/sysctl.conf <<'EOF'
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-arptables = 1
EOF