#!/usr/bin/bash

set -euo pipefail

NEW_USER="beanopy"

SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
WORK_PATH="/opt"
TMP_PATH="/tmp"

REPO_PATH="${WORK_PATH}/home_config"
AUR_PATH="${TMP_PATH}/yay-bin"
AUR_URL="https://aur.archlinux.org/yay-bin.git"

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

function set_user_password() {
    local user=${1:-root}

    status=$(passwd -S "${user}" | awk '{print $2}')
    if [[ "${status}" != "P" ]]; then
        INFO "Please set the password for ${user}"
        passwd "${user}"
    else
        INFO "${user} password is already set -- skipping"
    fi
}

function install_home() {
    cd "${TMP_PATH}"

    INFO "Install home configurations"
    "${REPO_PATH}"/hcfg.py install home

    if [[ ! $(command -v yay 2>/dev/null) ]]; then
        if [[ ! -d "${AUR_PATH}" ]]; then
            INFO "Clone ${AUR_URL}"
            git clone --depth=1 "${AUR_URL}"
        elif [[ -d "${AUR_PATH}/.git" && -O "${AUR_PATH}/.git"  ]]; then
            INFO "Update ${AUR_URL}"
            git -C "${AUR_PATH}"  pull
        fi

        INFO "Install yay"
        cd "${AUR_PATH}"
        makepkg -si --noconfirm --skippgpcheck
    fi

    INFO "Install aur packages"
    yay -S --needed --noconfirm swapspace zramswap \
        mihomo-bin pacman-cleanup-hook rime-ice-pinyin-git metacubexg-bin \
        bdf-unifont nerd-fonts-sarasa-term \
        emmet-language-server
        #xone-dkms proton-ge-custom-bin
    cd "${TMP_PATH}"

    uv tool install basedpyright

    ln -s "/run/media/${NEW_USER}" "/home/${NEW_USER}/mnt"

    INFO "Initialize neovim"
    nvim --headless +qa
}

function install_rootfs() {
    cd "${WORK_PATH}"

    INFO "Install system configurations to rootfs"
    "${REPO_PATH}"/hcfg.py install rootfs
    locale-gen

    INFO "Install packages"
    pacman -Syyu --noconfirm

    pacman -S --needed --noconfirm man-db man-pages texinfo \
        arch-install-scripts efibootmgr dosfstools \
        base-devel ccache clang lldb llvm python cmake ninja typst tinymist websocat go gopls \
        neovim tree-sitter-cli lua-language-server yaml-language-server python-uv \
        bash-language-server typescript-language-server dockerfile-language-server \
        vscode-html-languageserver vscode-css-languageserver vscode-json-languageserver \
        rust-analyzer systemd-lsp \
        shellcheck shfmt \
        dhcpcd networkmanager wpa_supplicant ethtool inetutils wireless-regdb \
        bluez bluez-utils pulsemixer pipewire-alsa pipewire-jack pipewire-pulse udiskie \
        rsync 7zip fd fzf wget git openssh fish go-yq direnv docker \
        htop trash-cli yazi lazygit \
        nvidia-open nvidia-utils libva-nvidia-driver vulkan-radeon \
        hyprland uwsm hypridle xdg-desktop-portal-hyprland xorg-xwayland wl-clipboard \
        brightnessctl swaybg swaync waybar wofi \
        noto-fonts noto-fonts-cjk adobe-source-code-pro-fonts \
        noto-fonts-emoji otf-font-awesome ttf-nerd-fonts-symbols-mono \
        kitty chromium zathura zathura-pdf-poppler \
        fcitx5-im fcitx5-rime \
        arm-none-eabi-gcc arm-none-eabi-gdb assimp glfw stb \
        chntpw github-cli wireshark-qt postgresql \
        kicad rpi-imager \
        steam lib32-mesa gamemode gamescope

    INFO "Setup systemd services"
    systemctl enable NetworkManager
    systemctl enable bluetooth
    systemctl enable sshd

    INFO "Setup user configurations"
    id "${NEW_USER}" >/dev/null 2>&1 || useradd -m -s /usr/bin/fish "${NEW_USER}"
    echo "${NEW_USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/"${NEW_USER}"
    chmod 440 "/etc/sudoers.d/${NEW_USER}"
    runuser -u "${NEW_USER}" -- "${SCRIPT_PATH}" home
    rm "/etc/sudoers.d/${NEW_USER}"

    echo "%wheel ALL=(ALL:ALL) ALL" > "/etc/sudoers.d/wheel"
    chmod 440 "/etc/sudoers.d/wheel"
    usermod -aG wireshark,gamemode,docker,video,uucp,input,audio,wheel "${NEW_USER}"

    INFO "Setup aur/user related systemd services"
    systemctl enable swapspace
    systemctl enable zramswap
    systemctl enable mihomo@beanopy

    INFO "Regenerate initramfs"
    mkinitcpio -P

    INFO "Install systemd-boot bootloader"
    mkdir -p /boot/EFI/BOOT
    cp /usr/lib/systemd/boot/efi/systemd-bootx64.efi /boot/EFI/BOOT/BOOTX64.EFI
    bootctl --no-pager

    INFO "Installation done"
}

function main() {
    local arg="${1:-}"

    if [[ "${arg}" == "home" ]]; then
        install_home
    else
        install_rootfs
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi

