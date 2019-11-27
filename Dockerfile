FROM debian:sid-slim
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y flatpak-builder
RUN useradd -mUd /var/lib/builder builder
USER builder
WORKDIR /var/lib/builder
