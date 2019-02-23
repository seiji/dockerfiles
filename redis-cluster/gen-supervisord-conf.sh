#!/bin/sh

max_port="${1:-7000}"

program_entry_template ()
{
  local port=$1
  echo "
[program:redis-$port]
command=/usr/local/bin/redis-server /redis-conf/$port/redis.conf
stdout_logfile=/var/log/supervisor/%(program_name)s.log
stderr_logfile=/var/log/supervisor/%(program_name)s.log
autorestart=true
"
}

result_str="
[supervisord]
nodaemon=false
"

for port in `seq 7000 $max_port`; do
  result_str="$result_str$(program_entry_template $port)"
done

echo "$result_str"
