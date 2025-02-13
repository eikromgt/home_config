# video driver sepcific settings
#case $(lspci -k | grep -A 2 -E "(VGA|3D)") in
#*"NVIDIA"*)
#    xrandr --setprovideroutputsource modesetting NVIDIA-0
#    xrandr --auto
#    ;;
#*)
#    ;;
#esac

# monitor settings
if [[ "$(mons | head --lines=1 | cut --delimiter=' ' --fields=2)" -ne "1" ]] then
    xrandr --dpi 163
    #autorandr --change
    source ~/.screenlayout/n4k144_n2k60_discrete.sh
else
    xrandr --dpi 141
fi

# set up wallpaper for each monitor
# for head in $(mons | tail --lines=+3 | cut --delimiter=':' --fields=1); do
for head in $(seq 0 $(($(mons | head --lines=1 | cut --delimiter=' ' --fields=2) - 1))); do
    nitrogen --head=${head} --random --set-zoom-fill --no-recurse ~/picture/wallpaper/3840x2160/
done

# compositor
picom --fading &

# set cursor size
xrdb ~/.Xresources

# keymap
#[[ -f ~/.Xmodmap  ]] && (sleep 2; xmodmap ~/.Xmodmap) &

# unclutter
unclutter --start-hidden --idle 3 --jitter 2 --ignore-buttons 4,5 &

# set minimal brightness
light -N 2 &

# fcitx5
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export INPUT_METHOD=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus

fcitx5 &

# slstatus
slstatus &

# dwm
exec dwm
