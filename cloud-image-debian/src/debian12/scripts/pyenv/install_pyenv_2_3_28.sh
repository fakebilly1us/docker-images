#!/usr/bin/env bash
set -ex

apt-get update
apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl

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