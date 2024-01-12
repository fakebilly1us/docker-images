#!/usr/bin/env bash
set -ex

mv /etc/apt/sources.list /etc/apt/sources.list.bak

cp -a ./sources.list /etc/apt/sources.list

apt-get update