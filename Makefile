
.PHONY: build_all test compose decompose

build_all: build_freeswitch build_opensips build_sipp

build_%:
	cd build/$* && make build

test: compose
	bash tests/init.sh

compose: decompose
	docker-compose up -d

compose_foreground: decompose
	docker-compose up

decompose:
	docker-compose kill
	docker-compose down