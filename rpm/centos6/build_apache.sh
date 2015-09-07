#!/bin/env bash
WORKDIR=/opt/rpmbuild

APACHE_VERSION=${APACHE_VERSION:-"2.4.16"}
APR_VERSION=${APR_VERSION:-"1.5.2"}
APR_UTIL_VERSION=${APR_URIL_VERSION:-"1.5.4"}
DISTCACHE_VERSION=${DISTCACHE_VERSION:-"1.4.5-23"}

mkdir -p $WORKDIR/rpm/{BUILD,SRPMS,SPECS,SOURCES,RPMS}
echo "%_topdir $WORKDIR/rpm" > ~/.rpmmacros
echo "%_smp_mflags -j4" >> ~/.rpmmacros

# public key
wget https://www.apache.org/dist/httpd/KEYS
gpg --import KEYS
rm -f KEYS

# apr
wget ftp://ftp.riken.go.jp/net/apache/apr/apr-$APR_VERSION.tar.bz2 --directory-prefix $WORKDIR/rpm/SOURCES
wget https://www.apache.org/dist/apr/apr-$APR_VERSION.tar.bz2.asc
gpg --verify apr-$APR_VERSION.tar.bz2.asc $WORKDIR/rpm/SOURCES/apr-$APR_VERSION.tar.bz2
rpmbuild -ts --rmsource $WORKDIR/rpm/SOURCES/apr-*
yum-builddep -y $WORKDIR/rpm/SRPMS/apr-*.src.rpm
rpmbuild --rebuild --clean $WORKDIR/rpm/SRPMS/apr-*.src.rpm
rm apr-*.asc $WORKDIR/rpm/SRPMS/apr-*.src.rpm
rpm --upgrade --verbose --hash $WORKDIR/rpm/RPMS/*/apr{,-devel}-[0-9]*.rpm

# apr-util
wget ftp://ftp.riken.go.jp/net/apache/apr/apr-util-$APR_UTIL_VERSION.tar.bz2 --directory-prefix $WORKDIR/rpm/SOURCES
wget https://www.apache.org/dist/apr/apr-util-$APR_UTIL_VERSION.tar.bz2.asc
gpg --verify apr-util-$APR_UTIL_VERSION.tar.bz2.asc $WORKDIR/rpm/SOURCES/apr-util-$APR_UTIL_VERSION.tar.bz2
rpmbuild -ts --rmsource $WORKDIR/rpm/SOURCES/apr-util-*
yum-builddep -y $WORKDIR/rpm/SRPMS/apr-util-*.src.rpm
rpmbuild --rebuild --clean $WORKDIR/rpm/SRPMS/apr-util-*.src.rpm
rm apr-util-*.asc $WORKDIR/rpm/SRPMS/apr-util-*.src.rpm
rpm --upgrade --verbose --hash $WORKDIR/rpm/RPMS/*/apr-util-*.rpm

# distcache
rpm --import https://getfedora.org/static/1ACA3465.txt
yumdownloader --source --enablerepo=fedora-source-17 distcache --destdir $WORKDIR/rpm/SRPMS
rpm --checksig $WORKDIR/rpm/SRPMS/distcache-*.src.rpm
yum-builddep -y $WORKDIR/rpm/SRPMS/distcache-*.src.rpm
rpmbuild --rebuild --clean $WORKDIR/rpm/SRPMS/distcache-*.src.rpm
rm $WORKDIR/rpm/SRPMS/distcache-*.src.rpm
rpm --upgrade --verbose --hash $WORKDIR/rpm/RPMS/*/distcache-*.rpm

# apache
wget ftp://ftp.riken.go.jp/net/apache/httpd/httpd-$APACHE_VERSION.tar.bz2 --directory-prefix $WORKDIR/rpm/SOURCES
wget https://www.apache.org/dist/httpd/httpd-$APACHE_VERSION.tar.bz2.asc
gpg --verify httpd-$APACHE_VERSION.tar.bz2.asc $WORKDIR/rpm/SOURCES/httpd-$APACHE_VERSION.tar.bz2
rpmbuild -ts --rmsource $WORKDIR/rpm/SOURCES/httpd-*
yum-builddep -y $WORKDIR/rpm/SRPMS/httpd-*.src.rpm
rpmbuild --rebuild --clean $WORKDIR/rpm/SRPMS/httpd-*.src.rpm
rm httpd-*.asc $WORKDIR/rpm/SRPMS/httpd-*.src.rpm

cp $WORKDIR/rpm/RPMS/x86_64/* /shared/
