FROM amazonlinux:2

COPY fluent-package-lts.repo /etc/yum.repos.d/fluent-package-lts.repo

RUN command -v rpm && \
    rpm --import https://packages.treasuredata.com/GPG-KEY-td-agent && \
    rpm --import https://packages.treasuredata.com/GPG-KEY-fluent-package && \
    yum update && \
    yum install -y fluent-package

EXPOSE 24224
CMD [ "/sbin/init" ]
