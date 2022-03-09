all: remove extension install

VERSION=2.11-ext

remove:
	-docker extension remove portainer-docker-extension

extension:
	docker build -t portainer-docker-extension:$(VERSION) .
	
install:
	docker extension install portainer-docker-extension:$(VERSION)

multiarch:
	docker buildx create --name=buildx-multi-arch --driver=docker-container --driver-opt=network=host

build:
	docker buildx build --builder=buildx-multi-arch --platform=linux/amd64,linux/arm64 --build-arg TAG=$(VERSION) --tag=portainer/portainer-docker-extension:$(VERSION) .
