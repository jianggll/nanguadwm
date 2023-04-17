![dwm](./dwm.png)
- dynamic window manager
- dwm is an extremely fast, small, and dynamic window manager for X.
- fork version
- @kk4dl

### Requirements
In order to build dwm you need the Xlib header files.

### Installation
默认使用gcc编译，删除了Xinerama的支持，安装路径是~/.local

Enter the following command to build and install dwm

    make clean install

更多选项请查看Makefile文件

### Running dwm
Add the following line to your .xinitrc to start dwm using startx:

    exec dwm

In order to connect dwm to a specific display, make sure that the
DISPLAY environment variable is set correctly, e.g.:

    DISPLAY=foo.bar:1 exec dwm

(This will start dwm on display :1 of the host foo.bar.)

In order to display status info in the bar, you can do something
like this in your .xinitrc:

    while xsetroot -name "`date` `uptime | sed 's/.*,//'`"
    do
    	sleep 1
    done &
    exec dwm

### Configuration
The configuration of dwm is done by creating a custom config.h
and (re)compiling the source code.

程序本体由三个主要的c源文件组成
- dwm.c
- drw.c
- util.c
- **config.h**文件定义了一些变量，其中键位绑定，鼠标行为，和一些外
观方面的选项在这里定义

### Features
对比原版，改动的地方
- 边框间添加空隙，参考(https://dwm.suckless.org/patches/fullgaps/)
- 每个标签保持自己独立的布局(https://dwm.suckless.org/patches/pertag/)
