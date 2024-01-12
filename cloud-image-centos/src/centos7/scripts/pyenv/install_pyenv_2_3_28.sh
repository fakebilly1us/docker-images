#!/usr/bin/env bash
set -ex

yum -y install gcc make patch curl-devel expat-devel gettext-devel gdbm-devel openssl-devel sqlite-devel readline-devel zlib-devel bzip2-devel libcurl-devel python-backports-lzma xz-devel
yum -y install gcc-c++ perl-ExtUtils-MakeMaker

mkdir -pv /usr/local/pyenv
git clone https://github.com/pyenv/pyenv.git /usr/local/pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git /usr/local/pyenv/plugins/pyenv-virtualenv
cd /usr/local/pyenv && git checkout -b v2.3.28 v2.3.28 && cd -
cd /usr/local/pyenv/plugins/pyenv-virtualenv && git checkout -b v1.2.2 v1.2.2 && cd -

(cd /usr/local/pyenv && src/configure && make -C src && cd -) || true

cat >/etc/profile.d/pyenv.sh <<'EOF'
export PYENV_ROOT=/usr/local/pyenv
export PATH=$PATH:$PYENV_ROOT/bin
eval "$(pyenv init --path)" > /dev/null 2>&1
eval "$(pyenv virtualenv-init -)" > /dev/null 2>&1
EOF

chown -R root:root /usr/local/pyenv
chmod -R g+w /usr/local/pyenv

source /etc/profile && source /etc/profile.d/pyenv.sh

pyenv install 3.6.15
