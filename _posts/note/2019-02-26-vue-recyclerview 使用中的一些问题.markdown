---
layout: post
title: vue-recyclerview 使用中的一些问题
date: 2019-02-26
categories: note
permalink: 'note/vue_recyclerview_problem'
tags: vuejs
post_image: https://tva1.sinaimg.cn/large/006tNbRwgy1g9xtqvkmsqj30i207idfu.jpg
prefix: 笔记
---

## vue-recyclerview ? 

[**vue-recyclerview**](https://github.com/hilongjw/vue-recyclerview) 是大量数据列表显示的一个解决方案, 很好的解决了移动端上当数据过多时, 列表加载过多导致的内存占用画面卡顿等的问题.

![](/assets/images/2019-02-26/2019-02-26-15-20-58.gif)

插件本身看着不错, 很实用, Github的repo也有1200+的星:

![](/assets/images/2019-02-26/2019-02-26-15-25-19.png){:.w50}

但全网搜索不到任何详细讲解的博客内容, 搜索结果倒是很多, 但几乎清一色是转载repo自己的Readme内容. 没有任何建设性参考内容.

![](/assets/images/2019-02-26/2019-02-26-15-29-30.png){:.w60}

也有可能是因为使用方法过于简单(至少repo的Readme上的教程看着很简单?), 大多数开发者在使用的时候没有遇到什么的可以讨论的问题, 导致网上讨论的人少. 

但实际上在我使用这个插件的时候遇到了各种问题, Readme上的对各种Options的解释也都很笼统(例如`options`里的`props`有什么作用也没有解释清楚). 遇到的各种问题中有一些自己摸索出来解决了, 但对其原因和正确与否还不是很确定, 打算在这里做些记录.

至于需要插件的使用方法的朋友还是去**官方看Doc**比较好, 这里只是些**错误笔记**.

[https://github.com/hilongjw/vue-recyclerview](https://github.com/hilongjw/vue-recyclerview) 

## Problems?

### - 插件的大小必须设置

列表中的每一项都是`position: absolute`, 通过`transform: translate3d(x,x,x)` 来排列成列表的样子. 

插件的标签是`<RecyclerView>`, 渲染后会生成类名为**recyclerview-container**的div: `<div class="recyclerview-container"></div>`. 若没有提前设置好size, absolute排列的列表项是不会显示的. 

使用插件时可以直接添加控制插件大小的`style`属性: (官方教程)
```html
 <RecyclerView
      style="height: calc(100vh - 50px)"
      :prerender="30"
      :fetch="MiFetch" 
      :item="MiItem" 
      :tombstone="MiTomstone"
    ></RecyclerView>
```
当然也可以为`.recyclerview-container`设置css属性.
```css

```