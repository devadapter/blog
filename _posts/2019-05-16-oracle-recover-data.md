---
layout: post
title: oracle下误删数据恢复的方法
date:  2019-05-16
author: 似水年崋
toc: true
cover: /img/cover/sql-exception.jpg
tags: ['oracle','java','删库跑路','恢复数据']
---

> 当我们误删数据时，除了删库跑路还有没有别的方法呢？

<!-- more -->

### 删库

> 删除表中数据有三种方法：

1. delete
2. drop
3. truncate

> 下面就跟随博主的脚步，一步步走向删库跑路的康庄大道吧。

### delete误删除时，我们该怎么办

**原理：利用oracle提供的闪回方法，如果在删除数据后还没做大量的操作（只要保证被删除数据的块没被覆写），就可以利用闪回方式直接找回删除的数据**

1. 确定删除数据的时间（在删除数据之前的时间就行，不过最好是删除数据的时间点）

2. 用以下语句找出删除的数据：

   ```sql
   select * from 表名 as of timestamp to_timestamp('删除时间点','yyyy-mm-dd hh24:mi:ss')
   ```

3. 把删除的数据重新插入原表(注意要保证主键不重复)：

   ```sql
    insert into 表名 (select * from 表名 as of timestamp to_timestamp('删除时间点','yyyy-mm-dd hh24:mi:ss')); 
   ```

**如果表结构没有发生改变，还可以直接使用闪回整个表的方式来恢复数据。**

**具体步骤：**

> 表闪回要求用户必须要有flash any table权限

#### 开启行移动功能

```sql
alter table 表名 enable row movement
```

#### 恢复表数据

```sql
flashback table 表名 to timestamp to_timestamp(删除时间点','yyyy-mm-dd hh24:mi:ss')
```

#### 关闭行移动功能 ( 千万别忘记 )

```sql
alter table 表名 disable row movement
```

### drop误删除的解决方法

**原理：由于oracle在删除表时，没有直接清空表所占的块,oracle把这些已删除的表的信息放到了一个虚拟容器“回收站”中，而只是对该表的数据块做了可以被覆写的标志，所以在块未被重新使用前还可以恢复**

* 查询这个“回收站”或者查询user_table视图来查找已被删除的表

```sql
 select table_name,dropped from user_tables;
 
 select object_name,original_name,type,droptime from user_recyclebin;
```

> 在以上信息中，表名都是被重命名过的，字段table_name或者object_name就是删除后在回收站中的存放表名

* 如果还能记住表名，则可以用下面语句直接恢复

```sql
flashback table 原表名 to before drop
```

如果记不住了，也可以直接使用回收站的表名进行恢复，然后再重命名，参照以下语句：

```sql
flashback table "回收站中的表名(如：Bin$DSbdfd4rdfdfdfegdfsf==$0)" to before drop rename to 新表名
```

**oracle的闪回功能除了以上基本功能外，还可以闪回整个数据库：**

使用数据库闪回功能，可以使数据库回到过去某一状态, 语法如下：

```sql
alter database flashback on;
flashback database to scn SCNNO;
flashback database to timestamp to_timestamp('2007-2-12 12:00:00','yyyy-mm-dd hh24:mi:ss');
```

### 总结：
oracle提供以上机制保证了安全操作，但同时也代来了另外一个问题，就是空间占用，由于以上机制的运行，使用drop一个表或者delete数据后，空间不会自动回收，对于一些确定不使用的表，删除时要同时回收空间，可以有以下2种方式：

* 采用truncate方式进行截断。（但不能进行数据回恢复了）

* 在drop时加上purge选项：drop table 表名 purge

**该选项还有以下用途：**

也可以通过删除recyclebin区域来永久性删除表 ,原始删除表

```sql
drop table emp cascade constraints purge table emp;
```

删除当前用户的回收站:

```sql
drop table emp cascade constraints purge recyclebin;
```

删除全体用户在回收站的数据:

```sql
drop table emp cascade constraints purge dba_recyclebin
```
