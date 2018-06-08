FROM amazonlinux:2

RUN yum update -y && yum install -y -q yum-utils build-essential git tar wget which tcl zlib-devel jemalloc-devel
RUN yum groupinstall -y 'Development tools'
RUN yum clean all
RUN rpm --import http://ftp.riken.jp/Linux/fedora/epel/RPM-GPG-KEY-EPEL-7

WORKDIR /opt/rpmbuild

ADD apache /opt/rpmbuild/apache24/
