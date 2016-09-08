#!/bin/sh
set -e

ES_PORT_9200_TCP_ADDR=${ES_PORT_9200_TCP_ADDR:-localhost}
ES_PORT_9200_TCP_PORT=${ES_PORT_9200_TCP_PORT:-9200}

if [ "$1" = 'kibana' ]; then
  sed -i "s;^elasticsearch_url:.*;elasticsearch_url: http://${ES_PORT_9200_TCP_ADDR}:${ES_PORT_9200_TCP_PORT};" "/opt/kibana/config/kibana.yml"
  exec /opt/kibana/bin/kibana

else
    exec "$@"
fi

