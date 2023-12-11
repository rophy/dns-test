init:
	scripts/init.sh

restart:
	docker-compose restart

build:
	docker-compose build

test:
	scripts/test.sh
