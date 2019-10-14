PROJ_ROOT = $(realpath ./)

.PHONY: up siege start stop test

up:
	docker-compose up \
		--force-recreate \
		--remove-orphans

start:
	docker-compose up -d \
		--force-recreate \
		--remove-orphans
stop:
	docker-compose stop

test: stop start siege

siege:
	siege -q -r 100 -c 10 \
		--log=/tmp/siege.log \
		http://localhost:8888
	cat /tmp/siege.log
