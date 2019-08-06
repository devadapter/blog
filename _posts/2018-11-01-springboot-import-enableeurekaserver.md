---
layout: post
title: springboot无法引入@enableeurekaserver
date: 2018-11-01
author: 似水年崋
toc: true
cover: /img/cover/spring-boot.png
tags: ['springboot', 'eureka','springcloud']
---

### 项目添加eureka依赖时，总是无法成功引入。导致程序@enableeurekaserver报错

**最终找到原因是springboot与springcloud的支持版本不一致**

<!-- more -->

### 解决办法修改pom.xml

```xml
<dependencies>
   <dependency>
      <groupId>org.springframework.cloud</groupId>
      <artifactId>spring-cloud-starter-netflix-eureka-server</artifactId>
   </dependency>
   <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-test</artifactId>
      <scope>test</scope>
   </dependency>
 
</dependencies>
 
   <dependencyManagement>
       <dependencies>
           <dependency>
               <groupId>org.springframework.cloud</groupId>
               <artifactId>spring-cloud-dependencies</artifactId>
               <version>Finchley.RELEASE</version>
               <type>pom</type>
               <scope>import</scope>
           </dependency>
       </dependencies>
   </dependencyManagement>
```

后成功运行

###  版本号规则
Spring Cloud并没有使用熟悉的数字版本号，而是对应一个开发代号。

| Cloud代号 | Boot版本(train) | Boot版本(tested)      | lifecycle        |
| --------- | --------------- | --------------------- | ---------------- |
| Angle     | 1.2.x           | incompatible with 1.3 | EOL in July 2017 |
| Brixton   | 1.3.x           | 1.4.x                 | 2017-07卒        |
| Camden    | 1.4.x           | 1.5.x                 | -                |
| Dalston   | 1.5.x           | not expected 2.x      | -                |
| Edgware   | 1.5.x           | not expected 2.x      | -                |
| Finchley  | 2.x             | not expected 1.5.x    | -                |


开发代号看似没有什么规律，但实际上首字母是有顺序的，比如：Dalston版本，我们可以简称 D 版本，对应的 Edgware 版本我们可以简称 E 版本。

作者：[alsoAm](https://me.csdn.net/alsoAm)
来源：CSDN
原文转载：[https://blog.csdn.net/zhang53141/article/details/83091032](https://blog.csdn.net/zhang53141/article/details/83091032)

