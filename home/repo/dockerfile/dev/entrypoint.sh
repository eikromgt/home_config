#!/bin/bash

if [[ -S /var/run/docker.sock ]]; then
    GID=$(stat -c %g /var/run/docker.sock)
    groupadd -g $GID hostdocker 2>/dev/null || true
    usermod -aG $GID beanopy
fi

exec "$@"
