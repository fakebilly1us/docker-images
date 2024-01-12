#!/usr/bin/env bash
set -e

# reset root passwd
echo "CENTOS_ROOT_PASSWORD_TO_SET" | passwd --stdin root
