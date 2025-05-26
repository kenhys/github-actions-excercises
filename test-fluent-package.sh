#!/usr/bin/bash

set -uex

CUID=$(id -u)
SUDO=""
if [ $CUID -ne 0 ]; then
    SUDO="sudo"
fi
$SUDO yum update -y
$SUDO rpm --import https://packages.treasuredata.com/GPG-KEY-td-agent
$SUDO rpm --import https://packages.treasuredata.com/GPG-KEY-fluent-package
$SUDO cat >/etc/yum.repos.d/fluent-package-lts.repo <<'EOF';
[fluent-package-lts]
name=Fluentd Project
baseurl=https://packages.treasuredata.com/lts/5/redhat/$releasever/$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.treasuredata.com/GPG-KEY-td-agent
       https://packages.treasuredata.com/GPG-KEY-fluent-package
EOF
cat /etc/yum.repos.d/fluent-package-lts.repo
$SUDO yum update -y
$SUDO yum install -y fluent-package
systemctl status fluent-package
