#!/usr/bin/env bash
set -ex

yum remove git
yum -y install gcc make patch package curl-devel expat-devel gettext-devel gdbm-devel openssl-devel sqlite-devel readline-devel zlib-devel bzip2-devel libcurl-devel ncurses-devel
yum -y install gcc-c++ perl-ExtUtils-MakeMaker

wget -qO /opt/cloud/centos7/scripts/git/git-2.36.6.tar.gz https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.36.6.tar.gz
tar -zxf /opt/cloud/centos7/scripts/git/git-2.36.6.tar.gz -C /opt/cloud/centos7/scripts/git/

cd /opt/cloud/centos7/scripts/git/git-2.36.6
./configure --prefix=/usr/local/git all
make prefix=/usr/local/git all
make prefix=/usr/local/git install
cd -

cat >/etc/profile.d/git.sh <<'EOF'
export GIT_HOME=/usr/local/git
export PATH=$GIT_HOME/bin:$PATH
EOF

source /etc/profile && source /etc/profile.d/git.sh