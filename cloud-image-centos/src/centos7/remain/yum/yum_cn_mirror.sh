#!/usr/bin/env bash
set -ex

cp -a /etc/yum.repos.d /etc/yum.repos.d.bak

sed -e 's|^mirrorlist=|#mirrorlist=|g' \
    -e 's|^#baseurl=http://mirror.centos.org/centos|baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos|g' \
    -i.bak \
    /etc/yum.repos.d/CentOS-*.repo
sed -e 's+https://download.docker.com+https://mirrors.tuna.tsinghua.edu.cn/docker-ce+' -i.bak /etc/yum.repos.d/docker-ce.repo

yum makecache