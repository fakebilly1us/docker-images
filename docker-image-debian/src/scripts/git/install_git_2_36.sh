#!/usr/bin/env bash
set -ex

apt-get -y remove git
apt-get -y purge git
apt-get -y autoremove
apt-get clean
apt-get update
apt-get install -y gcc make build-essential zlib1g-dev libssl-dev dh-autoreconf libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev install-info

wget -qO /opt/initialization/scripts/git/git-2.36.6.tar.gz https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.36.6.tar.gz
tar -zxf /opt/initialization/scripts/git/git-2.36.6.tar.gz -C /opt/initialization/scripts/git/
cd /opt/initialization/scripts/git/git-2.36.6
./configure --prefix=/usr/local/git all
make prefix=/usr/local/git all
make prefix=/usr/local/git install
cd -

cat >/etc/profile.d/git.sh <<'EOF'
export GIT_HOME=/usr/local/git
export PATH=$GIT_HOME/bin:$PATH
EOF

source /etc/profile && source /etc/profile.d/git.sh