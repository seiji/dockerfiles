FROM redis:5.0.3-alpine3.9

# RUN \
#   mkdir -p /etc/apk &&\
#   echo "http://alpine.gliderlabs.com/alpine/edge/main" > /etc/apk/repositories &&\
#   apk --update add curl ruby &&\
#   gem install --no-ri --no-rdoc redis &&\
#   curl -sLO http://download.redis.io/redis-stable/src/redis-trib.rb &&\
#   mv -i redis-trib.rb /usr/local/bin/ &&\
#   chmod +x /usr/local/bin/redis-trib.rb &&\
#   apk del curl &&\
#   rm -rf /tmp/* /var/cache/apk/*


# ADD ./run.sh /tmp/run.sh
# RUN chmod +x /tmp/run.sh
# ADD ./redis-proto.sh /usr/local/bin/redis-proto.sh
# RUN chmod +x /usr/local/bin/redis-proto.sh

# VOLUME ["/var/lib/redis"]
# EXPOSE 6379 16379
# ENTRYPOINT ["/tmp/run.sh"]
# CMD ["redis-server", "/etc/redis.conf"]

COPY redis.conf /etc/
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 6379
CMD ["redis-server", "/etc/redis.conf"]
