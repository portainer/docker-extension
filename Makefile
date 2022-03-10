all: remove extension install

ORG=portainer
PORTAINER_IMAGE_NAME=portainerci/portainer
TAG=pr6644
IMAGE_NAME=$(ORG)/portainer-docker-extension
TAGGED_IMAGE_NAME=$(IMAGE_NAME):$(TAG)

remove:
	-docker extension remove $(ORG)_portainer-docker-extension
	-docker rmi $(PORTAINER_IMAGE_NAME):$(TAG)

extension:
	docker build -t $(TAGGED_IMAGE_NAME) --build-arg TAG=$(TAG) --build-arg PORTAINER_IMAGE_NAME=$(PORTAINER_IMAGE_NAME) .
	
install:
	docker extension install $(TAGGED_IMAGE_NAME)

multiarch:
	docker buildx create --name=buildx-multi-arch --driver=docker-container --driver-opt=network=host

build:
	docker buildx build --builder=buildx-multi-arch --platform=linux/amd64,linux/arm64 --build-arg TAG=$(VERSION) --build-arg PORTAINER_IMAGE_NAME=$(PORTAINER_IMAGE_NAME) --tag=$(TAGGED_IMAGE_NAME) .
