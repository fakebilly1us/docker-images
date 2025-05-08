ARG BASE_TAG="17.0.2-jdk-bullseye"
ARG BASE_IMAGE="openjdk"
FROM $BASE_IMAGE:$BASE_TAG

LABEL maintainer="fakebilly.work@outlook.com"
LABEL org.opencontainers.image.authors="FakeBilly"

ARG LANG='en_US.UTF-8'
ARG LANGUAGE='en_US.UTF-8'
ARG LC_ALL='en_US.UTF-8'

ENV DEBIAN_FRONTEND=noninteractive \
    RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo

USER root

COPY --chown=root:root src/initialization /opt/initialization

RUN bash /opt/initialization/init_first.sh

ENV LANG=$LANG \
    LANGUAGE=$LANGUAGE \
    LC_ALL=$LC_ALL \
    TZ=Asia/Hong_Kong

#ONBUILD ADD target/*.jar /usr/software/service/app.jar
#
#ONBUILD WORKDIR /usr/software/service/
#
#ONBUILD ENTRYPOINT ["/opt/initialization/startup.sh"]
