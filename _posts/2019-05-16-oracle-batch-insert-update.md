---
layout: post
title: oracle下批量新增和修改
date:  2019-05-16
author: 似水年崋
toc: true
cover: /img/cover/happy-coding.jpg
tags: ['oracle','批量新增','端批量修改','mybatis']
---

> mybatis批量新增、修改oracle数据库

<!-- more -->

### 批量新增

```xml
  <insert id="addScheduling" parameterType="DrSourcegInfo" useGeneratedKeys="false">
    <foreach collection="list" item="happiness" open="begin" close=";end;" index="index" separator=";">
      insert into dr_sourceg_info
      (reg_no, store_id, doc_no,reg_date,reg_sts,reg_typ,tm_flg,reg_num,surplus_num,tm_smp)
      values
      (#{happiness.regNo},#{happiness.storeId},
      #{happiness.docNo},#{happiness.regDate},
      #{happiness.regSts}, #{happiness.regTyp},
      #{happiness.tmFlg},#{happiness.regNum},
      #{happiness.surplusNum},#{happiness.tmSmp})
    </foreach>
  </insert>

```

### 批量修改

```sql
 <update id="delectScheduling" parameterType="java.util.List">
        <foreach collection="list" item="regNo" open="begin" close=";end;" index="index" separator=";">
            update dr_sourceg_info
            set reg_sts = '1'
            where reg_no = #{regNo}
        </foreach>
  </update>
```

