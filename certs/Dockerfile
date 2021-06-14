FROM alpine:3

RUN apk add --no-cache openssl
RUN openssl version

WORKDIR /etc/ssl

COPY openssl.cnf /etc/ssl/openssl.cnf
COPY gen.sh .
RUN chmod +x ./gen.sh
