PROJ_ROOT = $(realpath ./)

MAKEFLAGS  += --no-builtin-rules
.SUFFIXES:
.SECONDARY:
.DELETE_ON_ERROR:

UNIT  ?= amazon-ssm-agent

SRC_REPO_OWNER         ?= aws
SRC_REPO               ?= ${SRC_REPO_OWNER}/${UNIT}
SRC                    ?= github.com/${SRC_REPO}
SRC_VERSION            ?= 2.0.922.0
SRC_DIR                ?= /go/src/${SRC}
BIN_DIR                ?= /usr/local/amazon/bin
LOG_DIR                ?= /var/log/amazon/ssm
CONF_DIR               ?= /etc/amazon/ssm
REPO_INFO              ?= .repo.json

.PHONY: all help image push

all: help

help:
	@echo "Usage: make <target>"
	@echo " "
	@echo "  where <target> is one of:"
	@echo "    - help               - display this help message"
	@echo "    - all/<package>      - build binary, image, flatten, and push (choices: ${UNIT})"
	@echo "    - bin                - build amazon-ssm-agent binary for packaging"
	@echo "    - bin/<package>      - build binary for specified package (choices: ${UNIT})"
	@echo "    - download           - download the src for compilation"
	@echo "    - get-release-info   - download src repo version info  (choices: 'latest' or release 'tag')"
	@echo "    - gen-systemd-unit   - render systemd unit file"
	@echo "    - image              - bundle container image for all package(s)"
	@echo "    - image/<package>    - bundle container image for specified package (choices: ${UNIT})"
	@echo "    - lint               - lint dockerfile based on the rules defined in linter.yml for all package(s)"
	@echo "    - lint /<package>    - lint dockerfile for specified package (choices: ${UNIT})"
	@echo "    - push               - push container image(s) for all package(s) to registry"
	@echo "    - push/<package>     - push container image for specified package to registry (choices: ${UNIT})"
	@echo "    - clean              - clean temp files, etc. for all packages"
	@echo "    - clean/<package>    - clean temp files, etc. for specified package (choices: ${UNIT})"
	@exit 0

build:
	docker run \
	  --rm \
	  -e SRC_DIR=${SRC_DIR} -e BIN_DIR=/stage${BIN_DIR} -e CONF_DIR=/stage${CONF_DIR} \
	  -w ${SRC_DIR} \
	  -v ${PWD}/stage${BIN_DIR}:/stage${BIN_DIR} \
	  -v ${PWD}/stage${CONF_DIR}:/stage${CONF_DIR} \
	  -v ${PWD}/${UNIT}:${SRC_DIR} \
	  golang:${GOLANG_VERSION} \
	  /bin/sh -c 'apk add --no-cache bash git make && make build-linux && install -m 500 bin/linux_amd64/* $$BIN_DIR/ && install -m 400 $$SRC_DIR/amazon-ssm-agent.json.template $$CONF_DIR/amazon-ssm-agent.json && install -m 400 $$SRC_DIR/seelog_unix.xml $$CONF_DIR/seelog.xml'
