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
        mihomo pacman-cleanup-hook sc-im\
        bdf-unifont fcitx5-pinyin-moegirl nerd-fonts-noto-sans-mono nerd-fonts-sarasa-term \
        xone-dkms-git proton-ge-custom-bin
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
    pacman -S --needed --noconfirm man-db man-pages texinfo \
        arch-install-scripts efibootmgr \
        base-devel clang lldb llvm python cmake typst \
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
        kicad rpi-imager steam lib-mesa gamemode gamescope

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

adobe-source-code-pro-fonts 2.042u+1.062i+1.026vf-2
adobe-source-han-sans-cn-fonts 2.005-1
alsa-utils 1.2.15.2-1
amd-ucode 20260110-1
anything-sync-daemon 6.0.0-3
arch-install-scripts 31-1
arm-none-eabi-gcc 14.2.0-1
arm-none-eabi-gdb 17.1-1
assimp 6.0.4-1
base 3-2
bash-language-server 5.6.0-1
bc 1.08.2-1
bear 4.0.2-1
bluez-utils 5.85-1
boost 1.89.0-4
brightnessctl 0.5.1-3
chntpw 140201-5
chromium 144.0.7559.109-1
docker 1:29.2.0-1
docker-compose 5.0.2-1
dolphin 25.12.1-1
ethtool 1:6.15-1
fbset 2.1-11
fcitx5-chinese-addons 5.1.11-1
fcitx5-configtool 5.1.12-1
fcitx5-gtk 5.1.5-1
fcitx5-nord 0.0.0.20210727-2
fcitx5-pinyin-zhwiki 1:0.3.0.20251223-1
fio 3.41-1
gamemode 1.8.2-1
gamescope 3.16.19-3
github-cli 2.86.0-1
glfw 1:3.4-1
go-yq 4.52.1-1
hdparm 9.65-3
hiredis 1.3.0-1
htop 3.4.1-1
hypridle 0.1.7-6
hyprland 0.53.3-1
inetutils 2.7-2
inotify-tools 4.25.9.0-1
intel-ucode 20251111-1
iotop 0.6-13
kicad 9.0.7-5
kitty 0.45.0-4
lazygit 0.58.1-1
lib32-gamemode 1.8.2-1
libva-nvidia-driver 0.0.15-1
lua-language-server 3.17.1-1
man-pages 6.16-1
mariadb 12.1.2-1
mesa-utils 9.0.0-7
net-tools 2.10-3
networkmanager 1.54.3-1
noto-fonts-emoji 1:2.051-1
nvidia-open 590.48.01-9
nvidia-prime 1.0-5
obs-studio 32.0.4-1
ollama-cuda 0.15.2-1
openocd 1:0.12.0-5
profile-sync-daemon 1:6.51-1
pulsemixer 1.5.1-8
python-lsp-server 1.14.0-1
python-pandas 2.3.3-1
rcs 5.10.1-3
rlwrap 0.48-1
rpi-imager 2.0.6-1
rust 1:1.93.0-1
screen 5.0.1-3
stb r2216.f1c79c0-1
swaybg 1.2.1-1
swaync 0.12.4-1
texlive-bibtexextra 2025.2-3
texlive-context 2025.2-3
texlive-fontsextra 2025.2-3
texlive-formatsextra 2025.2-3
texlive-games 2025.2-3
texlive-humanities 2025.2-3
texlive-langarabic 2025.2-3
texlive-langchinese 2025.2-3
texlive-langcyrillic 2025.2-3
texlive-langczechslovak 2025.2-3
texlive-langenglish 2025.2-3
texlive-langeuropean 2025.2-3
texlive-langfrench 2025.2-3
texlive-langgerman 2025.2-3
texlive-langgreek 2025.2-3
texlive-langitalian 2025.2-3
texlive-langjapanese 2025.2-3
texlive-langkorean 2025.2-3
texlive-langother 2025.2-3
texlive-langpolish 2025.2-3
texlive-langportuguese 2025.2-3
texlive-langspanish 2025.2-3
texlive-luatex 2025.2-3
texlive-mathscience 2025.2-3
texlive-metapost 2025.2-3
texlive-music 2025.2-3
texlive-pstricks 2025.2-3
texlive-publishers 2025.2-3
texlive-xetex 2025.2-3
trash-cli 0.24.5.26-3
tree 2.2.1-1
tree-sitter-bash 0.25.0-1
tree-sitter-cli 0.25.10-3
tree-sitter-python 0.25.0-1
ttf-nerd-fonts-symbols-mono 3.4.0-1
typst 1:0.14.2-1
udiskie 2.6.1-1
unzip 6.0-23
valkey 8.1.4-1
virtualbox 7.2.6-1
vulkan-tools 1.4.335.0-1
w3m 0.5.5-1
waybar 0.14.0-6
wget 1.25.0-3
yaml-language-server 1.19.2-1
yazi 26.1.22-1
zip 3.0-11

compdb 0.2.0-1
fcitx5-pinyin-moegirl 20250810-1
grub-silent 2.06-6
kmscon-patched-git 9.0.0.r34.ga81941f-1
mihomo 1.19.12-1
nerd-fonts-noto-sans-mono 3.2.1-1
nerd-fonts-sarasa-term 1:2.3.1-1
nrf5-sdk 17.1.0-2
nrfutil 8.1.1-1
pacman-cleanup-hook 1.1-1
polychromatic 0.9.5-1
proton-ge-custom-bin 1:GE_Proton10_20-1
python-adafruit-nrfutil 0.5.3.post17-2
python-cmsis-svd-git 0.6.r0.ge1f3120-1
sc-im 0.8.5-1
stm32cubemx 6.15.0-1
stm32cubeprog 2.19.0-1
swapspace 1.18-1
uf2-utils-git r8.3ca6d14-2
visual-studio-code-bin 1.103.1-1
wemeet-bin 3.19.2.400-3
xone-dkms-git 0.4.1.r0.gcb4c3d2-1
yay 12.5.7-1
zramswap 7-2
