FROM redis:5.0.3-alpine3.9

RUN apk --no-cache add libintl supervisor && \
      apk --no-cache add --virtual .gettext gettext && \
      cp /usr/bin/envsubst /usr/local/bin/envsubst && \
      apk del .gettext

RUN mkdir /etc/supervisor /var/log/supervisor
RUN mkdir /redis-conf /redis-data

COPY redis-cluster.tmpl /redis-conf/

COPY gen-supervisord-conf.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/gen-supervisord-conf.sh

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 7000

CMD ["redis-cluster"]
