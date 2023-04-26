![dwm](./dwm.png)

- dynamic window manager
- dwm is an extremely fast, small, and dynamic window manager for X.
- fork version
- @jianggl

## Requirements

In order to build dwm you need the Xlib header files.

## Installation
默认使用`gcc`编译，安装路径是`${HOME}/.local`

Enter the following command to build and install dwm

    make clean install

将`${HOME}/.local/bin`添加到PATH变量

`example: .bash_profile`
```
PATH="${HOME}/.local/bin:$PATH"
```

## Running dwm
Add the following line to your .xinitrc to start dwm using startx:

    exec dwm

In order to connect dwm to a specific display, make sure that the
DISPLAY environment variable is set correctly, e.g.:

    DISPLAY=foo.bar:1 exec dwm

(This will start dwm on display :1 of the host foo.bar.)

## .xinitrc

### 设置壁纸
```
change_wallpaper() {
	path_to_image="${HOME}/Pictures/wallpaper-summer"
	feh -z --bg-fill ${path_to_image}
}
wallpaper() {
	while change_wallpaper; do
		sleep 12h
	done &
}
wallpaper
```

### 触摸板
```
touchpad() {
    # Get id of touchpad and the id of the field corresponding to
    # tapping to click
    id=`xinput list | grep "Touchpad" | cut -d'=' -f2 | cut -d'[' -f1`
    tap_to_click_id=`xinput list-props $id | \
                          grep "Tapping Enabled (" \
                          | cut -d'(' -f2 | cut -d')' -f1`

    # Set the property to true
    xinput --set-prop $id $tap_to_click_id 1

    # Get id of touchpad and the id of the field corresponding to
    # natural scrolling
    id=`xinput list | grep "Touchpad" | cut -d'=' -f2 | cut -d'[' -f1`
    natural_scrolling_id=`xinput list-props $id | \
                          grep "Natural Scrolling Enabled (" \
                          | cut -d'(' -f2 | cut -d')' -f1`

    # Set the property to true
    xinput --set-prop $id $natural_scrolling_id 1
}
touchpad
```

### picom

```
setup_render() {
	/home/nangua/.local/bin/picom -b --experimental-backends
}
setup_render
```
### status

```
flash_status_bar() {
	time="$(date +%a\ %F\ %H:%M)"
	light_value="$(light)%"
	vol_value="$(amixer get Master|tail -1|awk -F '[' '{print $2}'|awk -F ']' '{print $1}')"
	bat="$(cat /sys/class/power_supply/BAT0/capacity)%"
	cpumode="$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)"
	xsetroot -name " ${time} | ${light_value} ${vol_value} ${bat} ${cpumode} "
}

status_bar() {
	while flash_status_bar; do
		sleep 5s
	done &
}
status_bar
```

### fcitx5
```
setup_fcitx() {
	export GTK_IM_MODULE=fcitx
	export QT_IM_MODULE=fcitx
	export XMODIFIERS=@im=fcitx
	#export SDL_IM_MODULE=fcitx
	#export GLFW_IM_MODULE=fcitx
	fcitx5 &
}
setup_fcitx
```

## Configuration
The configuration of dwm is done by creating a custom config.h
and (re)compiling the source code.

程序本体由三个主要的c源文件组成
- dwm.c
- drw.c
- util.c
- **config.h**文件定义了一些变量，其中键位绑定，鼠标行为，和一些外
观方面的选项在这里定义

## Features
对比原版，改动的地方
- 边框间添加空隙，参考(https://dwm.suckless.org/patches/fullgaps/)
- 每个标签保持自己独立的布局(https://dwm.suckless.org/patches/pertag/)
