FROM alpine:3.4

RUN \
  mkdir -p /etc/apk &&\
  echo "http://alpine.gliderlabs.com/alpine/edge/main" > /etc/apk/repositories &&\
  apk --update add redis curl ruby &&\
  sed -i 's/daemonize yes/daemonize no/g' /etc/redis.conf &&\
  sed -i 's/bind 127.0.0.1/bind 0.0.0.0/g' /etc/redis.conf &&\
  sed -i 's/logfile .*/logfile ""/g' /etc/redis.conf &&\
# cluster setting
  sed -i 's/# cluster-enabled yes/cluster-enabled yes/g' /etc/redis.conf &&\
  sed -i 's/# cluster-config-file nodes-6379.conf/cluster-config-file nodes-6379.conf/g' /etc/redis.conf &&\
  sed -i 's/# cluster-node-timeout 15000/cluster-node-timeout 5000/g' /etc/redis.conf &&\
  gem install --no-ri --no-rdoc redis &&\
  curl -LO http://download.redis.io/redis-stable/src/redis-trib.rb &&\
  mv -i redis-trib.rb /usr/local/bin/ &&\
  chmod +x /usr/local/bin/redis-trib.rb &&\
  apk del curl &&\
  rm -rf /tmp/* /var/cache/apk/*

ENV REDIS_MAJOR 3.0
ENV REDIS_VERSION 3.0.0-rc4
ENV REDIS_REPLICATION_MASTER **False**
ENV REDIS_REPLICATION_SLAVE **False**

ADD ./run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh
ADD ./redis-proto.sh /usr/local/bin/redis-proto.sh
RUN chmod +x /usr/local/bin/redis-proto.sh

VOLUME ["/var/lib/redis"]
EXPOSE 6379 16379
ENTRYPOINT ["/tmp/run.sh"]
CMD ["redis-server", "/etc/redis.conf"]
