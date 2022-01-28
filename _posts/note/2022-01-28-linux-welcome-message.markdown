---
layout: post
title: 关于 Linux 系统的 Welcome Message
date: 2022-01-28 11:36:57 +0900
categories: note
permalink: 'note/welcome_message'
tags:  linux, ubuntu
post_image: assets/images/2022-01/welcome.jpeg
prefix: 笔记
---

![welcome message](/assets/images/2022-01/welcome.jpeg){: .center}
## 机制

ssh连接的时候触发`/etc/pam.d/login`, 运行其中的`**motd**`设置, 将`/etc/update-motd.d/`目录下的脚本全部运行一遍

## pam.d

**(Pluggable Authentication Modules)**  可动态加载验证模块. 

[Linux下PAM模块学习总结](https://www.cnblogs.com/kevingrace/p/8671964.html)

简单说就是在`/etc/pam.d/` 路径下可以放置一个验证模块, 需要的服务就可以调用, 验证模块的文件名就是service的名称.

ssh login的时候调用了 `/etc/pam.d/login`, 其中下面的部分调用了**Motd**.

```bash
# Prints the message of the day upon successful login.
# (Replaces the `MOTD_FILE' option in login.defs)
# This includes a dynamically generated part from /run/motd.dynamic
# and a static (admin-editable) part from /etc/motd.
session    optional   pam_motd.so motd=/run/motd.dynamic
session    optional   pam_motd.so noupdate
```

## Motd (message of today)

今日消息板块, 提供欢迎页面的各种信息.  路径为 `/etc/update-motd.d/,` **login**时路径下的每一个脚本都被运行一遍.

```bash
/etc/update-motd.d# ls
00-header     50-landscape-sysinfo  85-fwupd         90-updates-available       91-release-upgrade      95-hwe-eol      98-fsck-at-reboot
10-help-text  50-motd-news          88-esm-announce  91-contract-ua-esm-status  92-unattended-upgrades  97-overlayroot  98-reboot-required
```

修改, 或添加脚本就可修改Welcome Message

也可以创建一个 `/etc/motd` 文件, 里头填写想要显示的信息. 这个文件的内容将显示在所有上面脚本的最后.

## 个人案例

在腾讯云购买的服务器安装的Ubuntu, 进入时显示欢迎消息, 但却没有更新包的提示. 运行 apt list —upgradable 却有很多可以更新的包. 检查以后发现 `/etc/update-motd.d/` 路径下缺少90号脚本 `90-updates-available`, 从其他服务器复制过来添加可运行权限以后更新包消息就出现了. 

## 不显示Welcome Message

如果不想要显示任何欢迎消息的话, 除了更改上面的脚本, 还有一个方法. 就是在账号目录下创建一个空白的 .hushlogin

```bash
~: touch .hushlogin
```

## 连接

[Where does the "n packages can be upgraded" message come from](https://lists.ubuntu.com/archives/ubuntu-users/2011-May/244802.html)

[Show packages to be upgraded on login](https://askubuntu.com/questions/270528/show-packages-to-be-upgraded-on-login)

**[Linux下PAM模块学习总结](https://www.cnblogs.com/kevingrace/p/8671964.html)**