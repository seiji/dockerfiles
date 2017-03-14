#!/bin/env bash
WORKDIR=/opt/rpmbuild

REDIS_VERSION=${REDIS_VERSION:-"3.2.8"}

mkdir -p $WORKDIR/rpm/{BUILD,SRPMS,SPECS,SOURCES,RPMS}
echo "%_topdir $WORKDIR/rpm" > ~/.rpmmacros
echo "%_smp_mflags -j4" >> ~/.rpmmacros

mv -i $WORKDIR/redis/redis.spec $WORKDIR/rpm/SPECS/
mv -i $WORKDIR/redis/*.patch $WORKDIR/rpm/SOURCES/
mv -i $WORKDIR/redis/redis-limit-init $WORKDIR/rpm/SOURCES/
mv -i $WORKDIR/redis/redis-limit-systemd $WORKDIR/rpm/SOURCES/
mv -i $WORKDIR/redis/redis-shutdown $WORKDIR/rpm/SOURCES/
mv -i $WORKDIR/redis/redis-sentinel.init $WORKDIR/rpm/SOURCES/
mv -i $WORKDIR/redis/redis-sentinel.service $WORKDIR/rpm/SOURCES/
mv -i $WORKDIR/redis/redis-shutdown $WORKDIR/rpm/SOURCES/
mv -i $WORKDIR/redis/redis.init $WORKDIR/rpm/SOURCES/
mv -i $WORKDIR/redis/redis.logrotate $WORKDIR/rpm/SOURCES/
mv -i $WORKDIR/redis/redis.service $WORKDIR/rpm/SOURCES/

# redis
# rpm -ivh http://dl.fedoraproject.org/pub/epel/6/SRPMS/redis-2.4.10-1.el6.src.rpm
wget https://github.com/antirez/redis/archive/$REDIS_VERSION.tar.gz -O $WORKDIR/rpm/SOURCES/redis-$REDIS_VERSION.tar.gz
rpmbuild -ba $WORKDIR/rpm/SPECS/redis.spec

cp $WORKDIR/rpm/RPMS/x86_64/* /shared/
