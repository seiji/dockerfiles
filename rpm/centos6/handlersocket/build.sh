#!/bin/env bash
WORKDIR=/opt/rpmbuild

MYSQL_VERSION=${MYSQL_VERSION:-"5.6.19"}
HANDLERSOCKET_VERSION=${HANDLERSOCKET_VERSION:-"1.1.1"}

mkdir -p $WORKDIR/rpm/{BUILD,SRPMS,SPECS,SOURCES,RPMS}
echo "%_topdir $WORKDIR/rpm" > ~/.rpmmacros
echo "%_smp_mflags -j4" >> ~/.rpmmacros

yum install -y perl-ExtUtils-MakeMaker perl-Test-Simple
# public key
rpm --import http://dev.mysql.com/doc/refman/5.6/en/checking-gpg-signature.html

function download_package () {
  wget http://dev.mysql.com/get/Downloads/MySQL-5.6/$1
  rpm --checksig $1
}

# MySQL RPMS
download_package MySQL-client-$MYSQL_VERSION-1.el6.x86_64.rpm
download_package MySQL-devel-$MYSQL_VERSION-1.el6.x86_64.rpm
download_package MySQL-server-$MYSQL_VERSION-1.el6.x86_64.rpm
download_package MySQL-shared-$MYSQL_VERSION-1.el6.x86_64.rpm
download_package MySQL-shared-compat-$MYSQL_VERSION-1.el6.x86_64.rpm

yum install -y MySQL-{client,devel,server,shared,shared-compat}-$MYSQL_VERSION-1.el6.x86_64.rpm

# MySQL Source
rpm -ivh http://dev.mysql.com/Downloads/MySQL-5.6/MySQL-$MYSQL_VERSION-1.el6.src.rpm
tar -zxf $WORKDIR/rpm/SOURCES/mysql-$MYSQL_VERSION.tar.gz

wget https://github.com/DeNA/HandlerSocket-Plugin-for-MySQL/archive/$HANDLERSOCKET_VERSION.tar.gz \
  -O $WORKDIR/rpm/SOURCES/HandlerSocket-Plugin-for-MySQL-$HANDLERSOCKET_VERSION.tar.gz
ls $WORKDIR/rpm/SOURCES/HandlerSocket-Plugin-for-MySQL-$HANDLERSOCKET_VERSION.tar.gz
tar -zxf $WORKDIR/rpm/SOURCES/HandlerSocket-Plugin-for-MySQL-$HANDLERSOCKET_VERSION.tar.gz

cd HandlerSocket-Plugin-for-MySQL-$HANDLERSOCKET_VERSION
./autogen.sh
./configure \
  --with-mysql-source=$WORKDIR/mysql-$MYSQL_VERSION \
  --with-mysql-bindir=/usr/bin \
  --with-mysql-plugindir=/usr/lib64/mysql/plugin
make rpm_cli
rpm -U dist/RPMS/*/libhsclient*.rpm
make rpm_c
rpm -U dist/RPMS/*/handlersocket*.rpm
make rpm_perl
rpm -U dist/RPMS/*/perl-Net-HandlerSocket*.rpm

cp dist/RPMS/x86_64/* /shared/
