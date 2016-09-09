FROM alpine:3.4

ENV KIBANA_VERSION 4.6.1-linux-x86_64

RUN \
  apk --update add \
  tzdata \
  curl \
  build-base \
  libffi-dev \
  sqlite-dev \
  libxml2-dev \
  libxslt-dev \
  nodejs \
  tzdata \
  ruby \
  ruby-json \
  ruby-bundler ruby-bigdecimal ruby-dev && \
  mkdir -p /opt && \
  cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
  echo "Asia/Tokyo"  >  /etc/timezone && \
  apk del curl tzdata && \
  rm -Rf /tmp/* /var/cache/apk/*

RUN mkdir /app

WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install

ENV RAILS_ENV dev

ADD . /app
RUN mkdir -p tmp/sockets

VOLUME /app/public
VOLUME /app/tmp

ADD ./run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh

EXPOSE 3000

ENTRYPOINT ["/tmp/run.sh"]
CMD ["rails"]
