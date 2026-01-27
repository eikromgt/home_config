#!/usr/bin/bash

set -euo pipefail

SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
USER="beanopy"

TIME_FORMAT="[%Y-%m-%d %H:%M:%S]"   # format example: [1917-01-01 00:00:00]

FORE_RED='\e[1;31m'
FORE_GREEN='\e[1;32m'
FORE_YELLOW='\e[1;33m'
FORE_WHITE='\e[1;37m'
BACK_RED='\e[1;41m'
NONE='\e[0m'

# Colored log
function LOG() {
    local color="${1}"
    shift

    printf "${color}$(date +"${TIME_FORMAT}") ${1}${NONE}\n" "${@:2}"
}

function DEBUG()    { LOG "${FORE_WHITE}"            "${@}"; }
function INFO()     { LOG "${FORE_GREEN}"            "${@}"; }
function WARN()     { LOG "${FORE_YELLOW}"           "${@}"; }
function ERROR()    { LOG "${FORE_RED}"              "${@}"; }
function FATAl()    { LOG "${BACK_RED}${FORE_WHITE}" "${@}"; }

function install_home() {
    cd /opt

    [[ ! -d /opt/home_config ]] && git clone --depth=1 https://github.com/eikromgt/home_config.git
    home_config/hcfg.py install home

    git clone --depth=1 https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si --noconfirm --skippgpcheck
    yay -S --noconfirm grub-silent swapspace zramswap kmscon-patched \
        mihomo pacman-cleanup-hook \
        bdf-unifont fcitx5-pinyin-moegirl nerd-fonts-noto-sans-mono nerd-fonts-sarasa-term
    cd /opt

    #systemctl --user enable update-vpn.timer
    #
}

function install_rootfs() {
    cd /opt/

    INFO "Install system configurations to rootfs"
    [[ ! -d /opt/home_config ]] && git clone --depth=1 https://github.com/eikromgt/home_config.git
    home_config/hcfg.py install rootfs

    locale-gen

    INFO "Install packages"
    pacman -S --noconfirm man-db man-pages texinfo \
        arch-install-scripts efibootmgr \
        neovim lua-language-server tree-sitter-cli \
        python-lsp-server python-pyflakes python-pycodestyle python-rope autopep8 \
        bash-language-server shellcheck shfmt \
        base-devel clang lldb llvm python cmake \
        dhcpcd networkmanager wpa_supplicant \
        bluez bluez-utils pulsemixer pipewire-alsa pipewire-jack pipewire-pulse udiskie \
        7zip fd fzf git htop openssh zsh trash-cli yazi\
        nvidia-open nvidia-utils \
        hyprland uwsm hypridle xdg-desktop-portal-hyprland xorg-xwayland wl-clipboard \
        brightnessctl swaybg swaync waybar wofi \
        adobe-source-code-pro-fonts adobe-source-han-sans-cn-fonts \
        noto-fonts-emoji otf-font-awesome ttf-nerd-fonts-symbols-mono \
        kitty dolphin chromium zathura zathura-pdf-poppler \
        fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt \
        fcitx5-chinese-addons fcitx5-nord fcitx5-pinyin-zhwiki


    INFO "Setup systemd services"
    systemctl enable NetworkManager
    systemctl enable bluetooth
    ystemctl enable sshd

    INFO "Setup user configurations"
    id "${USER}" >/dev/null 2>&1 || useradd -m -s /usr/bin/zsh "${USER}"
    echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/"${USER}"
    chmod 440 "/etc/sudoers.d/${USER}"
    runuser -u "${USER}" -- "${SCRIPT_PATH}" home
    rm "/etc/sudoers.d/${USER}"

    #systemctl enable mihomo@beanopy
    #
    #systemctl disable getty@tty2.service
    #systemctl enable kmsconvt@tty2
    #systemctl disable getty@tty2.service
    #systemctl enable kmsconvt@tty3
    #
    #systemctl enable swapspace
    #systemctl enable zramswap

    INFO "Reinstall system configurations to rootfs"
    ./hcfg.py install rootfs

    INFO "Regenerate initramfs"
    mkinitcpio -P
}


function main() {
    if [[ ${1} == "home" ]]; then
        install_home
    else
        install_rootfs
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
