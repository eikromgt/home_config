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
    yay -S --needed --noconfirm grub-silent swapspace zramswap \
        mihomo pacman-cleanup-hook \
        bdf-unifont fcitx5-pinyin-moegirl nerd-fonts-noto-sans-mono nerd-fonts-sarasa-term \
        xone-dkms proton-ge-custom-bin
    cd "${TMP_PATH}"

    INFO "Setup user systemd services"
    systemctl --user enable update-vpn.timer
}

function install_rootfs() {
    cd "${WORK_PATH}"

    INFO "Install system configurations to rootfs"
    "${REPO_PATH}"/hcfg.py install rootfs
    locale-gen

    INFO "Install packages"
    pacman -Syyu --noconfirm
    pacman -S --needed --noconfirm man-db man-pages texinfo \
        arch-install-scripts efibootmgr \
        base-devel clang lldb llvm python cmake typst go gopls \
        neovim tree-sitter-cli lua-language-server yaml-language-server python-lsp-server \
        autopep8 python-pyflakes python-pycodestyle python-rope python-pandas \
        bash-language-server shellcheck shfmt \
        dhcpcd networkmanager wpa_supplicant ethtool inetutils \
        bluez bluez-utils pulsemixer pipewire-alsa pipewire-jack pipewire-pulse udiskie \
        rsync 7zip fd fzf wget git openssh zsh go-yq \
        htop trash-cli yazi lazygit screen kmscon \
        nvidia-open nvidia-utils libva-nvidia-driver \
        hyprland uwsm hypridle xdg-desktop-portal-hyprland xorg-xwayland wl-clipboard \
        brightnessctl swaybg swaync waybar wofi \
        adobe-source-code-pro-fonts adobe-source-han-sans-cn-fonts \
        noto-fonts-emoji otf-font-awesome ttf-nerd-fonts-symbols-mono \
        kitty dolphin chromium zathura zathura-pdf-poppler \
        fcitx5-im fcitx5-chinese-addons fcitx5-nord fcitx5-pinyin-zhwiki \
        arm-none-eabi-gcc arm-none-eabi-gdb assimp glfw stb \
        chntpw docker github-cli \
        kicad rpi-imager steam lib32-mesa gamemode gamescope

    INFO "Setup systemd services"
    systemctl enable NetworkManager
    systemctl enable bluetooth
    systemctl enable sshd

    INFO "Setup user configurations"
    id "${NEW_USER}" >/dev/null 2>&1 || useradd -m -s /usr/bin/zsh "${NEW_USER}"
    echo "${NEW_USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/"${NEW_USER}"
    chmod 440 "/etc/sudoers.d/${NEW_USER}"
    runuser -u "${NEW_USER}" -- "${SCRIPT_PATH}" home
    rm "/etc/sudoers.d/${NEW_USER}"

    INFO "Setup aur/user related systemd services"
    systemctl disable getty@tty2.service
    systemctl enable kmsconvt@tty2
    systemctl disable getty@tty2.service
    systemctl enable kmsconvt@tty3
    systemctl enable swapspace
    systemctl enable zramswap
    systemctl enable mihomo@beanopy

    INFO "Reinstall system configurations to rootfs"
    "${REPO_PATH}"/hcfg.py install rootfs

    INFO "Regenerate initramfs"
    mkinitcpio -P

    INFO "Install GRUB bootloader"
    grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=HOST

    INFO "Generate GRUB configuration"
    grub-mkconfig -o /boot/grub/grub.cfg

    if passwd -S root 2>/dev/null | grep -q " NP "; then
        INFO "Please set the password for root"
        passwd
    else
        INFO "root password is already set -- skipping"
    fi

    if passwd -S "${NEW_USER}" 2>/dev/null | grep -q " NP "; then
        INFO "Please set the password for user: ${NEW_USER}"
        passwd "${NEW_USER}"
    else
        INFO "${NEW_USER} password is already set -- skipping"
    fi

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

