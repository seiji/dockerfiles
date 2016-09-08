#!/bin/sh
set -e

if [ "$1" = 'elasticsearch' ]; then
  exec /opt/elasticsearch/bin/elasticsearch -Des.insecure.allow.root=true
else
  exec "$@"
fi

