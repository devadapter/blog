---
layout: post
title: jenkins找回管理员密码
date: 2018-09-04
author: 似水年崋
toc: true
cover: /img/cover/centos-install-jenkins.png
tags: ['jenkins密码', 'jenkins','jenkins管理员']
---

>  有个时候我们忘记了jenkins管理员密码，由于jenkins没有使用数据库，所有的信息都保存在配置文件中。

>  这个时候我们可以通过更改配置文件来找回密码

<!-- more -->



##  Jenkins配置文件地址

**Linux**

```bash
 /var/lib/jenkins 或 /var/jenkins_home
```

**Windows**

```bash
C:\Users[用户名].jenkins
```

**Docker**

docker安装的Jenkins，那么JENKINS_HOME 目录和启动容器时指定的卷相关。

如 -v /home/demo/jenkins:/var/jenkins_home 参数中。

JENKINS_HOME 目录是 Docker 宿主机的 /home/demo/jenkins 目录。

### 管理员密码密文

Jenkins 中所有的用户信息都保存在 JENKINS_HOME 目录下的 users 目录中，每个用户对应一个目录。

**centos7.4** 下confing.xml文件路径

```bash
/var/lib/jenkins/users/admin
```

对应 admin 用户，可以查看 users/admin/config.xml 文件， 查找passwordHash

```bash
<passwodHash> 密码经过 hash 加密后的密文</passwodHash>
```

**重置密码为123456**

查找passwodHash节点

```bash
<passwodHash>密文</passwodHash>
```

将节点中的密文替换为

```bash
<passwodHash>#jbcrypt:$2a$10$MiIVR0rr/UhQBqT.bBq0QehTiQVqgNpUGyWW2nJObaVAM/2xSQdSq</passwodHash>
```

保存后重启Jenkins即可，此时Jenkins账号：admin，密码：123456
