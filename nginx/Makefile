PROJ_ROOT = $(realpath ./)

.PHONY: start stop test

start:
	docker-compose up \
		--force-recreate \
		--remove-orphans

stop:
	docker-compose stop

test:
	siege -q -t 5s -c 20 --log=/tmp/siege.log \
		http://localhost:8888
	cat /tmp/siege.log
