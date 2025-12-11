#!/usr/bin/bash

pacstrap -K /mnt base linux linux-firmware amd-ucode intel-ucode networkmanager \
    nvim man-db man-pages texinfo


base
linux
linux-firmware

amd-ucode
intel-ucode

base-devel
clang
lldb
llvm
python
cmake
efibootmgr
man-db
man-pages

dhcpcd
bluez
bluez-utils
pulsemixer
networkmanager
mihomo
pipewire-alsa
pipewire-jack
pipewire-pulse
kmscon-patched-git
wpa_supplicant
udiskie

7zip
fd
fzf
git
htop
neovim
ntfs-3g
openssh
pacman-cleanup-hook
zsh

bash-language-server
lua-language-server
python-lsp-server
tree-sitter-cli

nvidia-open
nvidia-utils


hyprland
uwsm
brightnessctl
hypridle
wl-clipboard
trash-cli
swaybg
swaync
waybar
wofi
xdg-desktop-portal-hyprland
xorg-xwayland

adobe-source-code-pro-fonts
adobe-source-han-sans-cn-fonts
nerd-fonts-noto-sans-mono
nerd-fonts-sarasa-term
noto-fonts-emoji
otf-font-awesome
ttf-nerd-fonts-symbols-mono

kitty
dolphin
chromium
fcitx5
fcitx5-chinese-addons
fcitx5-configtool
fcitx5-gtk
fcitx5-nord
fcitx5-pinyin-moegirl
fcitx5-pinyin-zhwiki
fcitx5-qt
openrazer-daemon
polychromatic
yazi
zathura
zathura-pdf-poppler

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
sed -i '/en_US.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf

echo 'Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch'          > /etc/pacman.d/mirrorlist
echo 'Server = https://mirrors.aliyun.com/archlinux/$repo/os/$arch'           >> /etc/pacman.d/mirrorlist
echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
echo 'Server = https://mirrors.bfsu.edu.cn/archlinux/$repo/os/$arch'          >> /etc/pacman.d/mirrorlist
sed -i 's/^#ParallelDownloads = .*/ParallelDownloads = 8/' /etc/pacman.conf \
pacman -Syu --noconfirm --needed
pacman -S --noconfirm base-devel neovim git cmake
clang python lua python-pynvim
llvm bash-language-server lua-language-server python-lsp-server
bear fd fzf ripgrep rsync openssh zsh p7zip yazi bc
pacman -Scc --noconfirm && rm -rf /var/cache/pacman/pkg/*

cd /tmp/
git clone --depth=1 https://github.com/eikromgt/home_config.git
cd home_config/
./hcfg.py install
cd /root && rm -rf /tmp/*

RUN nvim --headless "+Lazy! sync" "+TSUpdate" +qa

ENV SHELL=/bin/zsh
CMD ["/bin/zsh"]

