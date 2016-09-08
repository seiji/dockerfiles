FROM alpine:3.4

ENV KIBANA_VERSION 4.6.1-linux-x86_64

RUN \
  apk --update add curl nodejs && \
  mkdir -p /opt && \
  cd /tmp && \
  curl -sL "https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}.tar.gz" | tar -zx -C /tmp && \
  mv "/tmp/kibana-${KIBANA_VERSION}" /opt/kibana && \
  rm -rf /opt/kibana/node && \
  mkdir -p /opt/kibana/node/bin && \
  ln -sf /usr/bin/node /opt/kibana/node/bin/node && \
  apk del curl && \
  rm -Rf /tmp/* /var/cache/apk/*

ADD config/kibana.yml /opt/kibana/config/kibana.yml

ADD ./run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh

EXPOSE 5601

ENTRYPOINT ["/tmp/run.sh"]
CMD ["kibana"]
