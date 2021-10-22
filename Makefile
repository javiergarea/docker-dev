.PHONY: build run

IMAGE_TAG=javiergarea/dev:1.0

build:
	docker build -t ${IMAGE_TAG} .

run:
	docker run -it -v ~/dev:/root/dev ${IMAGE_TAG}
