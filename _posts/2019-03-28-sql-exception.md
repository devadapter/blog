---
layout: post
title: sql异常
date:  2019-02-15
author: 似水年崋
toc: true
cover: /img/cover/sql-exception.jpg
tags: ['mysql','java']
---

<!-- more -->

##  错误信息 

```java
java.sql.SQLException: The server time zone value 'ÖÐ¹ú±ê×¼Ê±¼ä' is unrecognized or represents more than one time zone. You must configure either the server or JDBC driver (via the serverTimezone configuration property) to use a more specifc time zone value if you want to utilize time zone support.
at com.mysql.cj.jdbc.exceptions.SQLError.createSQLException(SQLError.java:129) ~[mysql-connector-java-8.0.15.jar:8.0.15]
at com.mysql.cj.jdbc.exceptions.SQLError.createSQLException(SQLError.java:97) ~[mysql-connector-java-8.0.15.jar:8.0.15]
at com.mysql.cj.jdbc.exceptions.SQLError.createSQLException(SQLError.java:89) ~[mysql-connector-java-8.0.15.jar:8.0.15]
at com.mysql.cj.jdbc.exceptions.SQLError.createSQLException(SQLError.java:63) ~[mysql-connector-java-8.0.15.jar:8.0.15]
at com.mysql.cj.jdbc.exceptions.SQLError.createSQLException(SQLError.java:73) ~[mysql-connector-java-8.0.15.jar:8.0.15]
at com.mysql.cj.jdbc.exceptions.SQLExceptionsMapping.translateException(SQLExceptionsMapping.java:76) ~[mysql-connector-java-8.0.15.jar:8.0.15]
```

## 解决方法

**数据库表名后加: &serverTimezone=GMT%2B8**

```yml
url: jdbc:mysql://127.0.0.1:3306/mybatis?useUnicode=true&characterEncoding=utf8&serverTimezone=GMT%2B8
```

