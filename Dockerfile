# based on: https://github.com/joxz/alpine-ansible-py3
ARG ALPINE_VERSION=3.9
FROM alpine:${ALPINE_VERSION}

LABEL maintainer="Thomas Blaesing"

ARG SSH_PRV_KEY
ARG SSH_PUB_KEY

ARG ANSIBLE_VERSION="2.7.10"

# Install dependencies
RUN set -euxo pipefail \
 && sed -i 's/http\:\/\/dl-cdn.alpinelinux.org/https\:\/\/alpine.global.ssl.fastly.net/g' /etc/apk/repositories \
 && apk add --no-cache --update python3 ca-certificates openssh-client sshpass dumb-init su-exec zip bash \
 && apk add --no-cache --update --virtual .build-deps python3-dev build-base libffi-dev openssl-dev \
 && pip3 install --no-cache --upgrade pip \
 && pip3 install --no-cache --upgrade setuptools ansible==${ANSIBLE_VERSION} \
 && pip3 install --no-cache --upgrade proxmoxer requests \
 && apk del --no-cache --purge .build-deps \
 && rm -rf /var/cache/apk/* \
 && rm -rf /root/.cache \
 && ln -s /usr/bin/python3 /usr/bin/python

# Add the keys and set permissions
RUN mkdir -p /root/.ssh/ \
 && echo "$SSH_PRV_KEY" > /root/.ssh/id_rsa \
 && echo "$SSH_PUB_KEY" > /root/.ssh/id_rsa.pub

COPY files/config /root/.ssh/

RUN chmod 700 /root/.ssh/ \
 && chmod 600 /root/.ssh/id_rsa \
 && chmod 600 /root/.ssh/id_rsa.pub

# Initialize
RUN mkdir -p /etc/ansible \
 && mkdir -p /playbooks

WORKDIR /playbooks

# RUN
CMD ["/bin/bash"]
