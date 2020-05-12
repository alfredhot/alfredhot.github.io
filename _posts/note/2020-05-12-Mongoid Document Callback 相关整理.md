---
layout: post
title: Mongoid Document Callback 整理
date: 2020-05-12 14:00:18 +0900
categories: note
permalink: 'note/mongoid_callback'
tags: mongoid, rails
post_image: /assets/images/2020-05/mongoid.jpg
prefix: 笔记
---
mongoid的文档实在是不走心..

![mongoid](/assets/images/2020-05/mongoid.jpg){: .w50}

Mongodb的文档里对callback的说明过于简短, 只看文档弄不清楚callback实际被呼叫的时间点.
 尝试过在本地的mongoid安装包里也找源码, 也没有找到. 甚至在调用反馈函数的时候, Rubymine会提示该函数不存在.

![callback_sample](/assets/images/2020-05/mongoid_callback_sample.png){: .w50}

后来自己挨个尝试了一下, 函数的用法和文档中的一致, IDE报warning不用管它.
```ruby
class Article
    include Mongoid::Document
    field :name, type: String
    field :body, type: String
    field :slug, type: String
    before_create :send_message

    after_save do |document|
        # Handle callback here.
    end

    protected
    def send_message
        # Message sending code here.
    end

end
```

### 在官方给出的callback函数中, `around_`开头的反馈函数必须返回文档本身
`around_create`   
`around_update`  
`around_save`  
`around_destroy`  
这几个函数必须将文档本身作为传参并在函数最后将其return:
```ruby
    around_create do |doc|
        # handel your logic
        doc
    end
```
若不这样做的话, `create` 函数的过程就会被打断. 

以后有新的发现, 将在这里更新.


