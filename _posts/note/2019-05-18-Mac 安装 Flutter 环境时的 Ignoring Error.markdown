---
layout: post
title:   Mac 安装 Flutter 环境时的 Ignoring Error
date:   2019-05-18
categories: note
permalink: 'note/mac_flutter_ignoring_error'
tags: mac, flutter, ruby, gem, cocoapods
post_image: https://tva1.sinaimg.cn/large/006tNbRwgy1g9xtniejgfj30b405kaa0.jpg
prefix: 笔记
---

Flutter sdk包安装之后按照 `$flutter doctor` 命令的输出教程进行flutter环境配置的过程中, 安装完cocoapods, 进行`pod setup`遇到了一长串如下的error:

`Ignoring GEM because its extensions are not built.  Try: gem pristine GEM --version X.X.X`

具体的error截取如下: 

```bash
Ignoring rmagick-2.16.0 because its extensions are not built.  Try: gem pristine rmagick --version 2.16.0
Ignoring unf_ext-0.0.7.5 because its extensions are not built.  Try: gem pristine unf_ext --version 0.0.7.5
Ignoring unf_ext-0.0.7.4 because its extensions are not built.  Try: gem pristine unf_ext --version 0.0.7.4
Ignoring websocket-driver-0.7.0 because its extensions are not built.  Try: gem pristine websocket-driver --version 0.7.0
Ignoring websocket-driver-0.6.5 because its extensions are not built.  Try: gem pristine websocket-driver --version 0.6.5
/System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/lib/ruby/2.3.0/rubygems/core_ext/kernel_require.rb:120:in `require': incompatible library version - /Users/alfredhot/.rvm/gems/ruby-2.3.1/gems/bigdecimal-1.3.2/lib/bigdecimal.bundle (LoadError)
	from /System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/lib/ruby/2.3.0/rubygems/core_ext/kernel_require.rb:120:in `require'
...
```

折腾了半天, 在网上找到了原因.

因为cocoapods 是ruby语言, 安装的时候用的ruby, 和之前安装gem的时候的ruby版本不一样, 所以起了冲突.

可以运行一下`$which -a ruby`命令, 就可以看到系统里应该是安装了两个ruby.

我的解决办法是: 

`$gem update`

把系统里的gem全都更新了一遍, 不知道是不是在更新时使用的是系统当前使用的ruby, 总之 `$pods setup`愉快的运行起来了.

stack overflow里各路大神也给出了多样的解决办法. 如果有人用上面的方法也可以尝试一下大神们给出的思路.

 `$gem prestin --all`

如若不行, 可以尝试重新安装ruby

```bash
$reinstall ruby
$reinstall all gems
$gem pristine --all
```

问题应该能够解决.

参考: [Stack Overflow](https://stackoverflow.com/questions/38797458/ignoring-gem-because-its-extensions-are-not-built)
