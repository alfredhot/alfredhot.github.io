---
layout: post
title:  Sidekiq 报错时的操作 - error_handlers
date:   2019-12-13 14:00:10 +0900
categories: note
permalink: 'note/sidekiq_error_handlers'
prefix: 笔记
tags: rails ruby sidekiq
---

> Sidekiq 逻辑出错或报异常的时候, 我们会希望它能自动通知我们, 或者自动关闭一些线程什么的, 这些都可以在error_handlers里达成.

## error_handlers

打开`initialize/sidekiq.rb`, 找到 `Sidekiq.configure_server do |config|..`, 里头添加一下代码:
```ruby
Sidekiq.configure_server do |config|
    ...

    config.error_handlers << ->(ex, ctx_hash) do
      puts ex
      puts ctx_hash
    end
  end
```

以上代码在 `Sidekiq` 的 `config` 里添加了一个新的 `error_hendler`, `error_hendler`的参数有两个, `ex` 和 `ctx_hash`

通过打印出来的代码可以知道, `ex` 是报错内容,
`ctx_hash` 里是当前线程的信息, 和`sidekiq log` 里报错时打印出来的信息是一致的:
```ruby
# 我的报错信息
{"context"=>"Job raised exception", "job"=>{"class"=>"ErrorWorker", "args"=>[2004], "queue"=>"error", "enable"=>true, "retry"=>true, "jid"=>"41dd3793a2446b4941214988", "created_at"=>1576211786.9483526, "enqueued_at"=>1576211786.9486291}, "jobstr"=>"{\"class\":\"ErrorWorker\",\"args\":[2004],\"queue\":\"error\",\"enable\":true,\"retry\":true,\"jid\":\"41dd3793a2446b4941214988\",\"created_at\":1576211786.9483526,\"enqueued_at\":1576211786.9486291}"}
```

## 控制特定线程

有了`ctx_hash` 我们就可以针对特定的 `Worker` 特定的 `perform` 线程进行报错反馈.

比如我们要对 `MailWorker` 里参数为 `1000` 的线程进行报错反馈, 在线程报错时将报错内容记录到数据库中方便以后查看.
```ruby
config.error_handlers << ->(ex, ctx_hash) do
    if ctx_hash[:job]["class"] == "MailWorker" and ctx_hash[:job]["args"] == [1000]
        # 保存 ex到数据库
    end
end
```

## 最后

因为以上更改了 `initialize` 所以需要重启服务才能生效.