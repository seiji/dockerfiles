FROM golang:1.13.3-alpine

ARG SSM_VERSION="2.3.722.0"
ARG SRC_DIR="/go/src/amazon-ssm-agent"
ARG BIN_DIR="/usr/local/amazon/bin"
ARG CONF_DIR="/etc/amazon/ssm"

RUN apk add --no-cache --virtual .ssm-build bash curl git make gcc libc-dev \
  && go get golang.org/x/tools/cmd/goimports \
  && mkdir -p ${SRC_DIR} \
  && curl -sS -fL https://api.github.com/repos/aws/amazon-ssm-agent/tarball/${SSM_VERSION} \
  | tar --strip-components=1 -xzf - -C ${SRC_DIR} \
  && cd ${SRC_DIR} \
  && goimports -w ./agent/crypto/mocks/IBlockCipher.go \
  && goimports -w ./agent/health/mocks/IHealthCheck.go \
  && goimports -w ./agent/hibernation/mocks/IHibernate.go \
  && goimports -w ./agent/plugins/configurepackage/birdwatcher/facade/mocks/BirdwatcherFacade.go \
  && goimports -w ./agent/s3util/riputil.go \
  && goimports -w ./agent/session/communicator/mocks/IWebSocketChannel.go \
  && goimports -w ./agent/session/controlchannel/mocks/IControlChannel.go \
  && goimports -w ./agent/session/datachannel/mocks/IDataChannel.go \
  && goimports -w ./agent/session/plugins/sessionplugin/mocks/ISessionPlugin.go \
  && goimports -w ./agent/session/service/mocks/service.go \
  && make build-linux \
  && mkdir -p ${BIN_DIR} ${CONF_DIR} \
  && install -m 500 ${SRC_DIR}/bin/linux_amd64/* ${BIN_DIR}/ \
  && install -m 400 ${SRC_DIR}/amazon-ssm-agent.json.template ${CONF_DIR}/amazon-ssm-agent.json \
  && install -m 400 ${SRC_DIR}/seelog_unix.xml ${CONF_DIR}/seelog.xml \
	&& rm -Rf ${SRC_DIR} \
  && apk del .ssm-build
