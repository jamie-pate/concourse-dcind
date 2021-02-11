FROM alpine:3.10

ENV DOCKER_CHANNEL=stable \
    DOCKER_VERSION=20.10.3 \
    DOCKER_COMPOSE_VERSION=1.28.2 \
    DOCKER_SQUASH=1.0.8

# Install Docker, Docker Compose, Docker Squash
RUN apk --update --no-cache add \
    bash \
    ca-certificates \
    cargo \
    curl \
    device-mapper \
    gcc \
    git \
    iptables \
    less \
    libc-dev \
    libffi-dev \
    libressl-dev \
    make \
    musl-dev \
    openssh \
    py3-pip \
    python3 \
    python3-dev \
    util-linux \
    && \
    apk upgrade && \
    curl -fL "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" | tar zx && \
    mv /docker/* /bin/ && chmod +x /bin/docker* && \
    python3 -m pip install --upgrade pip && \
    pip3 install docker-compose==${DOCKER_COMPOSE_VERSION} && \
    pip3 install docker-squash==${DOCKER_SQUASH} && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apk/* && \
    rm -rf /root/.cache

COPY entrypoint.sh /bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
