FROM fedora:latest
MAINTAINER austin <austin.nwaka@yahoo.com>

RUN yum --assumeyes update && \
    yum --assumeyes install iproute openssh-server openssh-clients bash procps && \
    yum clean all

CMD ["/usr/bin/ssh-keygen", "-A"]
CMD ["/usr/sbin/sshd"]
