---
layout: post
title: windows系统下看端口、杀进程
date:  2019-05-16
author: 似水年崋
toc: true
cover: /img/cover/happy-coding.jpg
tags: ['windows','进程','端口号']
---

> windows系统如何查看端口是否被占用、查杀进程

<!-- more -->

> 首先是启动windows的命令窗口，按键盘上的windows+R，然后在输入框中输入cmd，既可以启动命令窗口

> 进入windows命令窗口之后，输入命令，输入netstat -ano然后回车，就可以看到系统当前所有的端口使用情况。

> 通过命令查找某一特定端口，在命令窗口中输入命令中输入netstat -ano |findstr "端口号"，然后回车就可以看到这个端口被哪个应用占用。

> 查看到对应的进程id之后，就可以通过id查找对应的进程名称，使用命令tasklist |findstr "进程id号"

> 通过命令杀掉进程，或者是直接根据进程的名称杀掉所有的进程，，在命令框中输入如下命令taskkill /f /t /im "进程id或者进程名称"

> 杀掉对应的进程id或者是进程名称之后，然后再通过查找命令，查找对应的端口，现在就可以看到这个端口没有被其他应用所占用，

