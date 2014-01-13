LetPaymentFly
=============
用 **客户端异步** 来解决跨系统支付时操作时间占用过长，从而导致Rails服务器并发处理能力下降的问题。

问题解析
-------------
问题的根结在于占用过多连接池，即使是用了类似NodeJS的异步模型。

解决方法有二，

１，服务器层面。

推荐基于EventMachine事件模型的Thin等Web服务器，但是这只是稍微减缓了服务器压力。

２，应用层面，也是本项目采用的机制，类似于把服务器端支付的异步模型改到了客户端的用户体验里。

在用户点击购买后，立即返回给用户一个处理中的界面，并在该界面里用JavaScript埋下一个定时获取支付状态相关的处理逻辑。

即用户到服务器这端每次操作都是可以毫秒级响应的，而服务器到银行这端则完全对用户屏蔽，用户只能查询目前的处理状态。

其中应用层的异步方案，后端采用 [resque](http://github.com/resque/resque) ，具体配置在 [lib/resque/payment.rb](https://github.com/mvj3/LetPaymentFly/blob/master/lib/resque/payment.rb) ，前端为 [JavaScript](https://github.com/mvj3/LetPaymentFly/blob/master/app/views/payment/buy.html.haml) 。

该方法从根本上解决了让该业务不影响其他业务逻辑正常访问的问题，不至于在服务器层面去大动干戈。

欢迎集思广益：）

使用方法
-------------
1, 安装相关库

```bash
bundle install
```

2, 运行数据库迁移脚本
```bash
bundle exec rake db:migrate
```

3, 确保redis服务启动，并跑起resque后台队列处理系统

```bash
QUEUE=* bundle exec rake resque:work
```

4, 启动Rails访问首页

```bash
bundle exec rails s
```

5, 点击购买测试
