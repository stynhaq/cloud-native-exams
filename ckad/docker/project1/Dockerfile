FROM centos:7
MAINTAINER austin <austin.nwaka@yahoo.com>

ADD ./austin.repo /etc/yum.repos.d/

#Install Software

RUN yum --assumeyes update && \
    yum --assumeyes install bash nmap iproute && \
    yum clean all

ENTRYPOINT ["/usr/bin/nmap"]
CMD ["-sn", "172.17.0.0/24"]
