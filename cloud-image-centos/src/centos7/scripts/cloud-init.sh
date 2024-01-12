#!/usr/bin/env bash
set -ex

# init customize cfg
chown -R root:root /opt/cloud/
tar -zxf /opt/cloud/centos7.tar.gz -C /opt/cloud/
chown -R root:root /opt/cloud/
cp /opt/cloud/centos7/cloud-init/cloud.cfg.d/*.cfg /etc/cloud/cloud.cfg.d/
chown root:root /etc/cloud/cloud.cfg.d/*.cfg && chmod 644 /etc/cloud/cloud.cfg.d/*.cfg
cp -a /opt/cloud/centos7/remain/ /opt/cloud/

# disabled SELINUX
sed -i -E 's/^#?SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config

sed -i -E -e 's/^#?PermitRootLogin.*/PermitRootLogin yes/g' \
          -e 's/^#?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
echo 'Port 12722' >> /etc/ssh/sshd_config
systemctl restart sshd

# sudoers
chmod +w /etc/sudoers
sed -i -E -e 's/^#?%wheel\s+ALL=\(ALL\)\s+ALL/#%wheel  ALL=(ALL)   ALL/g' \
          -e 's/^#?\s+%wheel\s+ALL=\(ALL\)\s+NOPASSWD:\s*ALL/%wheel ALL=(ALL)   NOPASSWD:ALL/g' /etc/sudoers
chmod -w /etc/sudoers

yum install wget -y
yum install -y wget curl net-tools bash-completion vim* telnet*

source /opt/cloud/centos7/scripts/git/install_git_2_36.sh \
    && source /opt/cloud/centos7/scripts/jdk/install_jdk.sh \
    && source /opt/cloud/centos7/scripts/maven/install_maven.sh \
    && source /opt/cloud/centos7/scripts/pyenv/install_pyenv_2_3_28.sh \
    && source /opt/cloud/centos7/scripts/nvm/install_nvm_0_39_5.sh \
    && source /opt/cloud/centos7/scripts/docker/install_docker_24_0_6.sh

source /opt/cloud/centos7/scripts/final/exec-final.sh

rm -rf /opt/cloud/centos7 /opt/cloud/centos7.tar.gz