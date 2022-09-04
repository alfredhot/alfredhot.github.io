---
layout: post
title: Jetbrains中项目丢失子模块(Submodule)现象
date: 2022-09-4 22:4:51 +0900
categories: note
permalink: 'note/2022-09-04-jetbrain-vcs'
tags:  jetbrains, rubymine, vcs, gitsubmodule, submodule
post_image: assets/images/2022-09/jetbrains.png
prefix: 笔记
---
> Jetbrains idea cannot track files from submodules 

![jetbrains](/assets/images/2022-09/jetbrains.png)

## problem
今天遇到一个奇怪的现象, 项目中的文件修改后提交列表里没有更改的文件. 修改的文件是在子模块A里, 正常来说子模块里的文件修改后也是正常出现在提交更改列表中, 但却看不到任何踪影, 所以也就没有办法用idea提交.
`git submodule` 能看到子模块列表是正常的:
```shell
git submodule

# --> output:
# df151a88e33b190ebe361c*********** ../C模块 (heads/main)
# 98bee4a557eb5640cfaa85*********** ../B模块 (heads/main)
# 9cf0919cb436ac7522b57d*********** ../A模块 (heads/main)
```
但在idea的右下角 branch 窗口却找不到A模块.
![vcs](/assets/images/2022-09/vcs.png)

## solution
idea有自己的vcs跟踪映射, 映射里的子模块缺失的话, 文件无论如何更改也不会被列到更改列表中.
这个映射在文件`./.idea/vcs.iml` 中管理. 我们只需要手动将遗失的子模块添加上去就可以了.

The idea control git tracking map in file `./.idea/vcs.iml`, it looks like idea lost submodule's mapping in some reason. We just need to add the lost mapping for the submodule. Everything goes right then.
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project version="4">
  <component name="VcsDirectoryMappings">
    <mapping directory="$PROJECT_DIR$" vcs="Git" />
    <mapping directory="$PROJECT_DIR$/C模块" vcs="Git" />
    <mapping directory="$PROJECT_DIR$/B模块" vcs="Git" />
    <mapping directory="$PROJECT_DIR$/A模块" vcs="Git" />
  </component>
</project>
```