#!/bin/sh
set -e

if [ "$1" = 'redis-server' ]; then
  sysctl -w vm.overcommit_memory=1
  echo never > /sys/kernel/mm/transparent_hugepage/enabled
  echo 511 > /proc/sys/net/core/somaxconn

  if [ ${REDIS_REPLICATION_MASTER} == "**False**" ]; then
    unset REDIS_REPLICATION_MASTER
  fi

  if [ ${REDIS_REPLICATION_SLAVE} == "**False**" ]; then
    unset REDIS_REPLICATION_SLAVE
  else
    set -- "$@" --slaveof "${REDIS_PORT_6379_TCP_ADDR}" "${REDIS_PORT_6379_TCP_PORT}"
  fi
fi

exec "$@"
