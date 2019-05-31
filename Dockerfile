# based on: https://github.com/joxz/alpine-ansible-py3
ARG ALPINE_VERSION=3.9
FROM alpine:${ALPINE_VERSION}

LABEL maintainer="@tehtbl"

ARG ANSIBLE_VERSION="2.8.0"

# Install dependencies
RUN set -euxo pipefail \
 && sed -i 's/http\:\/\/dl-cdn.alpinelinux.org/https\:\/\/alpine.global.ssl.fastly.net/g' /etc/apk/repositories \
 && apk add --no-cache --update python3 ca-certificates openssh-client sshpass dumb-init su-exec zip bash gnupg \
 && apk add --no-cache --update --virtual .build-deps python3-dev build-base libffi-dev openssl-dev \
 && pip3 install --no-cache --upgrade pip \
 && pip3 install --no-cache --upgrade setuptools ansible==${ANSIBLE_VERSION} \
 && pip3 install --no-cache --upgrade proxmoxer requests \
 && apk del --no-cache --purge .build-deps \
 && rm -rf /var/cache/apk/* \
 && rm -rf /root/.cache \
 && ln -s /usr/bin/python3 /usr/bin/python

# Initialize
RUN mkdir -p /etc/ansible \
 && mkdir -p /playbooks

COPY files/bashrc /root/.bashrc
COPY files/ans-vault-gpg-wrapper.sh /bin/ans-vault-gpg-wrapper.sh

RUN chmod +x /bin/ans-vault-gpg-wrapper.sh

# set working dir
WORKDIR /playbooks

# RUN
CMD ["/bin/bash"]
