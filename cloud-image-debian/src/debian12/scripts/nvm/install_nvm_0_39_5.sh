#!/usr/bin/env bash
set -ex

mkdir -pv /usr/local/nvm

git clone https://github.com/nvm-sh/nvm.git /usr/local/nvm
cd -pv /usr/local/nvm && git checkout -b v0.39.5 v0.39.5 && cd -

cat >/etc/profile.d/nvm.sh <<'EOF'
export NVM_DIR=/usr/local/nvm
export NVM_BIN=$NVM_DIR/versions/node
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[[ -r $NVM_DIR/bash_completion ]] && \. $NVM_DIR/bash_completion
EOF

source /etc/profile && source /etc/profile.d/nvm.sh

nvm install v12.22.12 \
    && nvm install v14.21.3 \
    && nvm install v16.20.2 \
    && nvm install v18.18.0 \
    && nvm alias default v16.20.2 \
    && nvm use default
