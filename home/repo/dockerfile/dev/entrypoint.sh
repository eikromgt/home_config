#!/bin/bash

if [[ -S /var/run/docker.sock ]]; then
    DOCKER_GID=$(stat -c %g /var/run/docker.sock)
    groupadd -g $DOCKER_GID host_docker 2>/dev/null || true
    usermod -aG $DOCKER_GID beanopy
fi

if [[ "$HOST_REPO" && -d "$HOST_REPO" ]]; then
    REPO_GID=$(stat -c %g "$HOST_REPO")
    groupadd -g $REPO_GID host_user 2>/dev/null || true
    usermod -aG $REPO_GID beanopy
    [[ -e /home/beanopy/hrepo ]] || ln -s "$HOST_REPO" /home/beanopy/hrepo
fi

if [[ "$COLOR_MODE" == "light"  ]]; then
    sed -i 's/vim.opt.background      = "dark"/vim.opt.background      = "light"/' /home/beanopy/.config/nvim/init.lua
    sed -i 's/theme = "gruvbox_dark_hard"/theme = "gruvbox_light_hard"/' /home/beanopy/.config/helix/config.toml
fi

exec "$@"
