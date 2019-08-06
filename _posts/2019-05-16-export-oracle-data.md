---
layout: post
title: 导出ORACLE表名、字段名、数据类型，长度，注释，是否非空
date:  2019-05-16
author: 似水年崋
toc: true
cover: /img/cover/sql-exception.jpg
tags: ['oracle','导出数据']
---

<!-- more -->

```sql
SELECT
a.TABLE_NAME 表名,
a.column_name 字段名,
a.data_type 数据类型,
a.data_length 长度,
b.comments 注释说明,
a.nullable 是否非空
FROM
user_tab_columns a,
user_col_comments b
WHERE
a.column_name = b.column_name
AND
a.table_name = b.table_name
AND
a.table_name = '你的表名';
```

