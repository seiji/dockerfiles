#!/bin/sh

if [ "$1" = 'redis-cluster' ]; then
  sysctl -w vm.overcommit_memory=1
  echo never > /sys/kernel/mm/transparent_hugepage/enabled
  echo 511 > /proc/sys/net/core/somaxconn
  # Allow passing in cluster IP by argument or environmental variable
  IP="${2:-$IP}"

  max_port=7002

  for port in `seq 7000 $max_port`; do
    mkdir -p /redis-conf/${port}
    mkdir -p /redis-data/${port}
    if [ -e /redis-data/${port}/nodes.conf ]; then
      rm /redis-data/${port}/nodes.conf
    fi

    PORT=${port} envsubst < /redis-conf/redis-cluster.tmpl > /redis-conf/${port}/redis.conf
  done

  gen-supervisord-conf.sh $max_port > /etc/supervisor/supervisord.conf
  supervisord -c /etc/supervisor/supervisord.conf
  sleep 3

  if [ -z "$IP" ]; then # If IP is unset then discover it
    IP=$(hostname -i)
  fi
  IP=$(echo ${IP}) # trim whitespaces

  echo "Using redis-cli to create the cluster"
  echo "yes" | redis-cli --cluster create ${IP}:7000 ${IP}:7001 ${IP}:7002
  tail -f /var/log/supervisor/redis*.log
else
  exec "$@"
fi
