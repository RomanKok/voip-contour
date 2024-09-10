DOCKER   = $(shell which docker 2>/dev/null)

IMG_NAME = sipp-ubuntu:22.04

.PHONY: build push

all: build

build: ./Dockerfile
	$(DOCKER) build -t $(IMG_NAME) .
