#!/usr/bin/env bash
set -ex

mkdir -pv /usr/local/jdk
wget -qO /opt/cloud/centos7/scripts/jdk/jdk-17.0.8.tar.gz https://download.oracle.com/java/17/archive/jdk-17.0.8_linux-x64_bin.tar.gz
tar -zxf /opt/cloud/centos7/scripts/jdk/jdk-17.0.8.tar.gz -C /usr/local/jdk/
wget -qO /opt/cloud/centos7/scripts/jdk/jdk-8u202-linux-x64.tar.gz 'https://www.dropbox.com/scl/fi/rfmvdctx7pkgv6i7r58fa/jdk-8u202-linux-x64.tar.gz?rlkey=9kx6r55pcbki6e6yenpdz5yd8&raw=1'
tar -zxf /opt/cloud/centos7/scripts/jdk/jdk-8u202-linux-x64.tar.gz -C /usr/local/jdk/

cat >/etc/profile.d/jdk.sh <<'EOF'
JAVA_HOME_8=/usr/local/jdk/jdk1.8.0_202
JAVA_HOME_17=/usr/local/jdk/jdk-17.0.8

export JAVA_HOME=$JAVA_HOME_17
export PATH=$PATH:$JAVA_HOME/bin

alias jdk8="export JAVA_HOME=$JAVA_HOME_8"
alias jdk17="export JAVA_HOME=$JAVA_HOME_17"
EOF

source /etc/profile && source /etc/profile.d/jdk.sh