FROM alpine:3.4

ENV JAVA_VERSION=8 \
    JAVA_UPDATE=45 \
    JAVA_BUILD=14 \
    JAVA_HOME=/usr/lib/jvm/default-jvm

ENV ES_MAJOR 2.4
ENV ES_VERSION 2.4.0

RUN \
  apk --update add curl ca-certificates openjdk7 && \
  mkdir -p /opt && \
  cd /tmp && \
  curl -sL "https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/${ES_VERSION}/elasticsearch-${ES_VERSION}.tar.gz" | tar -zx -C /tmp/ && \
  mv "/tmp/elasticsearch-${ES_VERSION}" /opt/elasticsearch && \
  apk del curl && \
  rm -Rf /tmp/* /var/cache/apk/*

# RUN /elasticsearch/bin/plugin --install elasticsearch/elasticsearch-analysis-kuromoji/2.5.0
# RUN /elasticsearch/bin/plugin --install mobz/elasticsearch-head
# RUN /elasticsearch/bin/plugin --install polyfractal/elasticsearch-inquisitor
# RUN /elasticsearch/bin/plugin --install elasticsearch/elasticsearch-river-twitter/2.5.0

ADD config/elasticsearch.yml /opt/elasticsearch/config/elasticsearch.yml
ADD config/stopword.txt /opt/elasticsearch/config/stopword.txt
ADD config/synonym.txt /opt/elasticsearch/config/synonym.txt
ADD config/userdict_ja.txt /opt/elasticsearch/config/userdict_ja.txt

ADD ./run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh

# WORKDIR /data
VOLUME ["/var/lib/elasticsearch"]

EXPOSE 9200
EXPOSE 9300

ENTRYPOINT ["/tmp/run.sh"]
CMD ["elasticsearch"]

