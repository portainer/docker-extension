ARG PORTAINER_IMAGE_NAME=portainerci/portainer
ARG TAG=pr6644

FROM $PORTAINER_IMAGE_NAME:$TAG AS portainer

FROM scratch

LABEL org.opencontainers.image.title="Portainer" \
    org.opencontainers.image.description="Portainer extension for Docker Desktop." \
    org.opencontainers.image.vendor="Portainer.io" \
    com.docker.desktop.extension.api.version="0.2.1" \
    com.docker.desktop.plugin.icon=https://portainer-io-assets.sfo2.cdn.digitaloceanspaces.com/logos/portainer.png

COPY portainer.svg .
COPY metadata.json .
COPY docker-compose.yml .

COPY --from=portainer /public /ui