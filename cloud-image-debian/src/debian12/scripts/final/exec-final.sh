#!/usr/bin/env bash
set -e

# reset root passwd
echo "root:DEBIAN_ROOT_PASSWORD_TO_SET" | chpasswd
