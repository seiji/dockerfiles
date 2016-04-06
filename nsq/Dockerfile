FROM alpine:latest

ENV NSQ_MAJOR 0.3
ENV NSQ_VERSION 0.3.7

RUN \
  mkdir -p /etc/apk &&\
  echo "http://alpine.gliderlabs.com/alpine/edge/main" > /etc/apk/repositories &&\
  apk --update add curl &&\
  mkdir -p /tmp/nsq &&\
  curl -sL https://s3.amazonaws.com/bitly-downloads/nsq/nsq-"${NSQ_VERSION}".linux-amd64.go1.6.tar.gz | tar zx -C /tmp/nsq &&\
  ls -la /tmp/nsq*/nsq*/bin &&\
  mv /tmp/nsq/nsq*/bin/* /usr/local/bin/ &&\
  rm -rf /tmp/nsq &&\

  apk del curl &&\
  rm -rf /tmp/* /var/cache/apk/*

WORKDIR /data
# nsqd
EXPOSE 4150
EXPOSE 4151
# nsqlookupd
EXPOSE 4160
EXPOSE 4161
# nsqadmin
EXPOSE 4171
CMD ["sh"]
