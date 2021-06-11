---
layout: post
title:  Jekyll安装时eventmachine 的openssl/ssl.h file not found  问题
date: 2021-06-11 13:23:56 +0900
categories: note
permalink: 'note/jekyll_eventmachine_error'
tags: jekyll
post_image: https://jekyllrb.com/img/logo-2x.png
prefix: 笔记
---

在公司电脑上安装Jekyll时发生错误

```bash
USER@USERPC ~ gem install jekyll bundler
Building native extensions. This could take a while...
ERROR:  Error installing jekyll:
	ERROR: Failed to build gem native extension.

    current directory: /Users/alfredhot/.rvm/gems/ruby-3.0.0/gems/eventmachine-1.2.7/ext
/Users/alfredhot/.rvm/rubies/ruby-3.0.0/bin/ruby -I /Users/alfredhot/.rvm/rubies/ruby-3.0.0/lib/ruby/site_ruby/3.0.0 -r ./siteconf20210611-19898-v767ei.rb extconf.rb
.
.
.
In file included from binder.cpp:20:
./project.h:119:10: fatal error: 'openssl/ssl.h' file not found
#include <openssl/ssl.h>
         ^~~~~~~~~~~~~~~
1 error generated.
make: *** [binder.o] Error 1
.
.
.
```

似乎是eventmachine 这个gem的默认安装有问题. so上参考了[这篇帖子](https://www.notion.so/Jekyll-eventmachine-openssl-ssl-h-file-not-found-b0fd5e1589b940249d7861f2d8d36330) 

[gem eventmachine fatal error: 'openssl/ssl.h' file not found](https://stackoverflow.com/a/30836309)

## 解决办法:

```bash
gem install eventmachine -- --with-cppflags=-I/usr/local/opt/openssl/include
```

之后再安装Jekyll就可以了