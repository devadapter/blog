---
layout: post
title: windows下搭建ElasticSearch系统及配置head插件
date:  2019-02-15
author: 似水年崋
toc: true
cover: /img/cover/windows-ElasticSearch.png
tags: ['ElasticSearch','grunt','ElasticSearch插件']
---

>  最近在学习ElasticSearch，记录下ElasticSearch安装与配置

<!-- more -->

##  安装前置条件

> java环境的配置，网上有太多介绍jdk安装与配置的教程了，这里就不作赘述了。

> 需要注意的是es系统现在需要的jdk版本是1.8。

> 这里我安装的环境是windows



### 安装ElasticSearch

1. 首先到 https://www.elastic.co/cn/downloads/elasticsearch 下载安装包，这里我选择的是zip包

   ![1](https://img-blog.csdn.net/20180718170141444?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2ZqeWFi/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

2. 将下载的zip解压到某个目录下，我是单独创建了目录。存放es系统的源码，D:\elasticsearch\elasticsearch-6.3.1
![2](https://img-blog.csdn.net/20180718170601962?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2ZqeWFi/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
3. 进入解压后的bin目录下，例：D:\elasticsearch\elasticsearch-6.3.1\bin，双击“elasticsearch.bat”启动，出现这个“started”就说明你启动成功。

启动成功后，你可以在浏览器中输入[“http://127.0.0.1:9200/](http://127.0.0.1:9200/)”地址，如果跳出以下页面，就ok了。

![img](https://img-blog.csdn.net/20180718170841719?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2ZqeWFi/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

### 安装head插件

>  安装head插件，必然是要先安装好nodejs和grunt才行。

#### 安装nodejs

打开 https://nodejs.org/en/download/ 地址，下载windows installer 的msi

![è¯·è¾å¥å¾çæè¿°](https://img-blog.csdn.net/20180718171219166?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2ZqeWFi/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

下载之后，双击msi，根据步骤安装nodejs即可，我把nodejs的安装目录设置为D:\elasticsearch\elasticsearch-6.3.1\nodejs。
安装完成之后，应该是可以直接使用node -v的命令来查看nodejs的版本的，但是在这儿我就遇到问题了。
nodejs安装完成之后，一开始我就在nodejs的目录下，使用node -v查看版本是可以查看版本的，但当我进行下一步想要安装grunt的时候，输入安装grunt的指令“npm install -g grunt-cli”之后，就出现了“npm不是内部或外部命令，也不是...”，命令完全无法执行，下一步执行不了，而且如果我不在nodejs目录下输入“node -v”，是看不到nodejs版本的，也就是说nodejs我并没有安装成功。我后来也重新安装了几次，还是出现这样的问题。后来在网上查询es系统的安装，关于nodejs的安装说是还有把NODE_HOME设置到环境变量里，但我设置之后并没有解决问题。最后是终于找到了解决方法！！！https://www.cnblogs.com/hackyo/p/8110951.html，安装nodejs除了环境变量，还要在nodejs的目录下新建两个文件夹：node-cache和node-global这是用来放npm全局模块的安装目录。
我按照这个方法做了之后，就解决了。

> 输入 “node -v”，查看nodejs的版本。如果安装正确，不论当前是什么目录，只要输入“node -v”都可以看到版本。

![1565064351130](C:/Users/J/AppData/Roaming/Typora/typora-user-images/1565064351130.png)

#### 安装grunt

还是在nodejs的目录下，输入指令：npm install -g grunt-cli 

安装成功输入grunt -version 会看到版本号

![è¯·è¾å¥å¾çæè¿°](https://img-blog.csdn.net/20180718173613395?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2ZqeWFi/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

#### 配置head

进入 [https://github.com/mobz/elasticsearch-head](http:// https//github.com/mobz/elasticsearch-head) 地址，下载zip，然后解压即可。

我把head直接放在了D:\elasticsearch\elasticsearch-head-master，这样好管理，当然大家随意。

1. 在head/Gruntfile.js里，添加一行 hostname: '*'

![è¯·è¾å¥å¾çæè¿°](https://img-blog.csdn.net/20180718174238305?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2ZqeWFi/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

2. 在head/_site/app.js中把localhost修改成你es的服务器地址，如：

> this.base_uri = this.config.base_uri || this.prefs.get("app-base_uri") || "http://111.11.11.1:9200";

![è¯·è¾å¥å¾çæè¿°](https://img-blog.csdn.net/20180718174657971?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2ZqeWFi/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

也可以不做修改。

3. 打开D:\elasticsearch\elasticsearch-6.3.1\config\elasticsearch.yml配置文件

    在文件的最后添加
   
    ```yml
   http.cors.enabled: true
    
   http.cors.allow-origin: "*"
   ```
   
    ![è¯·è¾å¥å¾çæè¿°](https://img-blog.csdn.net/20180718175147214?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2ZqeWFi/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
   
    去除文件中本来就有的几个注释

    ```yml
    cluster.name: my-application #集群的名字

    node.name: node-1 #节点名字

    network.host: 0.0.0.0 #ES的监听地址 

    http.port: 9200 #端口号，默认就好
    ```
   
   ![è¯·è¾å¥å¾çæè¿°](https://img-blog.csdn.net/20180718175412842?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2ZqeWFi/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
   
   保存完毕之后，到bin目录下，双击“elasticsearch.bat”启动
   
   然后在cmd命令行里，转到head目录下，输入 npm install
   
   然后还是head目录下，输入grunt server 启动nodejs，出现下面的提示，就启动成功
   
   ![è¯·è¾å¥å¾çæè¿°](https://img-blog.csdn.net/20180718180458211?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2ZqeWFi/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

作者： [fanmp](https://me.csdn.net/fjyab)

来源：CSDN

原文转载：https://blog.csdn.net/fjyab/article/details/81101284

