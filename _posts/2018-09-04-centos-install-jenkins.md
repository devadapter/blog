---
layout: post
title: centos7服务器安装jenkins
date: 2018-09-04
author: 似水年崋
toc: true
cover: /img/cover/centos-install-jenkins.png
tags: ['centos', 'jenkins']
---



<!-- more -->



##  安装前置条件

安装jenkins 需要首先配置 jdk

配置yum源

```bash

$ wget -O /etc/yum.repos.d/jenkins.repo http://jenkins-ci.org/RedHat/jenkins.repo

```

导入公钥

```bash

$ rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key

```

## 安装

```bash

$ yum install jenkins -y

```

## 查看安装后生成的文件

jenkins安装目录，war包路径

```bash
$ /usr/lib/jenkins/jenkins.war
```

配置文件路径

```bash
$ /etc/sysconfig/jenkins
```

启动脚本路径

```
$ /etc/rc.d/init.d/jenkins
```

日志文件路径

```
$ /var/log/jenkins/jenkins.log
```

## 启动jenkins 服务

```bash
$ systemctl start jenkins
```

打开jenkins管理页面

[localhost](http://localhost:8080/)

根据提示输入密码，安装所需要的插件即可。