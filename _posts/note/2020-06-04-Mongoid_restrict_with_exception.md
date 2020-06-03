---
layout: post
title: Mongoid dependent restric invalid
date: 2020-06-03 23:04:47 +0900
categories: note
permalink: 'note/mongoid_restict'
tags: mongoid, rails
post_image: https://tva1.sinaimg.cn/large/007S8ZIlgy1gffgh85tr3j30k60a0a9z.jpg
prefix: 笔记
---

## 官网..
Mongoid 官方教程中对于dependent的举例是这样的:

![official_site_capture](https://tva1.sinaimg.cn/large/007S8ZIlgy1gffgkrzqtlj30ho040q2u.jpg)

但是在mongoid7.0中除了`:destroy`, 和 `:nullify` 以外, 其他的dependent使用的话是会报 `Mongoid::Errors::InvalidDependentStrategy`的.  
一开始一头雾水, 网上也没有特别详细的示例, 也不排除水平太菜, 找资料都找不明白..

![InvalidDependentStrategy](https://tva1.sinaimg.cn/large/007S8ZIlgy1gffh5i37avj30ml049jr6.jpg)

## :delete
不知道.. 反正用不了. `:delete_all` 倒是可以用, 但是曾经有过一次: 删除一条记录的时候, 从属的记录所在的所有文档都会删除. 一直以为是`delete_all`的bug, 但后来又正常运作了. 这谁还敢用啊..

## :restric
在7.0中升级为 `restric_with_exception` 和 `restric_with_error`了,   
但官方的教程没有更改, 坑爹啊..

![official](/assets/images/2020-06/official_site_capture_2.png)

## 文档
官方的教程估计就是为了教你怎么入门的, 所以维护比较懈怠. 今天才发现版本的更改在官方的文档里才是最新的.  
读文档太枯燥, 所以一直以来都是有教程就看教程, 触类旁通全靠缘分. 这个习惯真的是得改改了.

![document](/assets/images/2020-06/document.png)