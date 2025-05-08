#!/usr/bin/env bash
set -ex

cat >/etc/profile.d/shortcut_keys.sh <<'EOF'
alias ll='ls -lF'

EOF

source /etc/profile && source /etc/profile.d/shortcut_keys.sh
