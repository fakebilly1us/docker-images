#!/usr/bin/env bash
set -ex

# sudoers
chmod +w /etc/sudoers
sed -i -E 's/^#?%sudo\s+ALL=\(ALL:ALL\)\s+ALL/%sudo ALL=(ALL) NOPASSWD:ALL/g' /etc/sudoers
echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
chmod -w /etc/sudoers

# 在 apt 2.1.9 及以后的版本中，apt 的 HTTP Pipelining 特性与 Nginx 服务器疑似存在一定的不兼容问题，可能导致高带宽从镜像站下载大量软件包
#（例如系统升级）时出现偶发的 Connection reset by peer 错误
#（详见 Debian bug #973581）。
#
# 目前，用户可以通过关闭 HTTP Pipelining 特性解决此问题。
# 如果需要关闭，可以在使用 apt 命令时加上 -o Acquire::http::Pipeline-Depth=0 参数，
# 或使用以下命令将相关设置加入 apt 系统配置中：
echo "Acquire::http::Pipeline-Depth \"0\";" > /etc/apt/apt.conf.d/99nopipelining

apt-get update
apt-get install -y apt-transport-https ca-certificates
apt install -y curl wget vim nano less procps net-tools iputils-ping apt-utils locales openssh-server zip unzip p7zip-full

# fix sshd start failed
sed -i -E -e 's/^#?PermitRootLogin.*/PermitRootLogin yes/g' \
          -e 's/^#?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
echo 'Port 12722' >> /etc/ssh/sshd_config

sed -i -e 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/g' \
      -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

source /opt/initialization/scripts/git/install_git_2_36.sh \
    && source /etc/profile \
    && source /opt/initialization/scripts/jdk/install_jdk.sh \
    && source /etc/profile \
    && source /opt/initialization/scripts/maven/install_maven.sh \
    && source /etc/profile \
    && source /opt/initialization/scripts/pyenv/install_pyenv_2_3_28.sh \
    && source /etc/profile \
    && source /opt/initialization/scripts/nvm/install_nvm_0_39_5.sh \
    && source /etc/profile \
    && source /opt/initialization/scripts/shortcutkey/shortcut_keys.sh \
    && source /etc/profile

# sources.list mirror
mv /etc/apt/sources.list /etc/apt/sources.list.bak
cp -a /opt/initialization/remain/apt/sources.list /etc/apt/sources.list
apt-get update

rm -rf /opt/initialization/scripts