#!/usr/bin/env bash
set -ex

# sources.list mirror
#mv /etc/apt/sources.list /etc/apt/sources.list.bak
#cp /opt/initialization/sources.list /etc/apt/sources.list

cat >/etc/profile.d/jdk.sh <<'EOF'
export JAVA_HOME=/usr/local/openjdk-8
export PATH=$PATH:$JAVA_HOME/bin
EOF

chmod +x /opt/initialization/startup.sh
mkdir -pv /usr/local/rustup
mkdir -pv /usr/local/cargo
mkdir -pv /usr/software/service
cp /opt/initialization/run.sh /usr/software/service/run.sh
chmod +x /usr/software/service/run.sh

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
apt install -y curl wget vim nano less procps net-tools iputils-ping locales

sed -i -e 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/g' \
      -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen

locale-gen

source /opt/initialization/scripts/git/install_git_2_36.sh \
    && source /etc/profile

source /opt/initialization/scripts/pyenv/install_pyenv_2_3_28.sh \
    && source /etc/profile

source /opt/initialization/scripts/git-fame/install_git-fame.sh

source /opt/initialization/scripts/rustup/install_rustup.sh \
    && source $CARGO_HOME/env

# tokei
cargo install tokei

sed -i '/cargo\/env/d' $HOME/.bashrc
cat >>$HOME/.bashrc <<'EOF'

alias ll='ls $LS_OPTIONS -la'

. /etc/profile
. /usr/local/cargo/env
EOF

