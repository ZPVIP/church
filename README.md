Church
======

这是在[亚琛华人基督徒团契](http://www.caachen.de) 使用的一套教会联系人和事奉管理系统，基本上是定制的所有功能，如果其它教会或查经班想使用本系统，可以改掉相关信息即可。

如果有功能上的建议或改进，欢迎发 Pull Request。

###部署到 Heroku
- 在[Heroku](http://www.heroku.com) 注册一个免费帐户，新建一个APP，比如说 caachen
- 在本地电脑上 clone 一份代码 `git clone git@github.com:ZPVIP/church.git`
- 把 config/database.example.yml 改名为  config/database.yml
- 打开 .gitignore，删除最后一行 database.yml，保存
- 点击 Heroku 最上面导航栏的 Databases 新建一个 Postgresql 数据库
- 将数据库 Connection Settings 的相关信息填入 config/database.yml 的 `production:` 下面
- 编辑 .git/config，最下面加上相关信息，请把 caachen 换成你的 APP 名字
```
[remote "heroku"]
url = git@heroku.com:caachen.git
fetch = +refs/heads/*:refs/remotes/heroku/*
```
- 安装 [heroku](https://toolbelt.heroku.com/) 命令行工具，然后执行以下命令就可以了跑起来了：
```
heroku login (输入用户名和密码)
git push heroku master
heroku run RAILS_ENV=production bundle exec rake assets:precompile
heroku run rake db:migrate
heroku run rake db:seed
heroku restart -a caachen
```
- 管理员帐号：Peter，密码 aaaaaaaa
- 注册用户默认只能在`欢迎新朋友`页面填写表单
- 其它用户权限需要管理员在`用户管理`页面编辑用户权限。

- 发送 Email，比如用在重置密码方面: 系统默认使用 Gmail 帐户，如使用其它 Email 系统可以在 config/environments/production.rb 更改
- 设置 Email 帐号，请将 www.caachen.de 换成你的网站域名，例子：`heroku config:add GMAIL_PASSWORD=password12345 GMAIL_USERNAME=youremail@gmail.com GMAIL_DOMAIN=gmail.com APP_DOMAIN=www.caachen.de`
- 第一次发送邮件时，Gmail 一般会认为有人黑了你的帐号，所以会发送失败，你可以先登录 Gmail，再点击这个[链接](https://www.google.com/accounts/DisplayUnlockCaptcha)。

## 系统使用说明

###如何添加一个联系人？

- 如果想把老通讯录的联系人信息转移到本系统，点击‘联系人列表’页面标题右侧的绿色‘添加’按钮。注意填写的时候在‘审核’那行打钩。
- 如果是以后聚会中的新朋友，可以邀请他们直接填写‘欢迎新朋友’页面（需要用接待组的同工的手机和账号登录）。
- 聚会结束后，请负责的同工在联系人列表里审核新朋友的信息，补充新朋友未添加的信息，添加备注，将其加入到相应的小组（比如说周报组，福音朋友组等）。
- 注意审核结束后在‘审核’那行打钩。如果以后这位新朋友决志或受洗，那么需要更新该联系人的资料。 

###如何查看一个联系人的详细资料？
- 在‘联系人列表’页面点击联系人的名字会可以查看该联系人的详细资料。

###如何更新一个联系人的详细资料？
- 在‘联系人列表’页面最后一列有编辑按钮，点击后可以更新该联系人的详细资料。

###为什么有些联系人背景为红色？
- 未经过审核的联系人背景为红色，比如说通过‘欢迎新朋友’页面添加的联系人。

###如何创建服事模板？
- 服事模板用于创建服事值日表，如果团契目前有`查经班`和`福音班`两项服事，每个服事有不同的人带领，主题也不一样。
- 进入‘服事定义’页面，创建服事模板，一共分为两级，比如说：
```
 查经班
     带领
     主题
 福音班
     带领
     主题
```

###如何填写服事值日表？
- 进入‘服事值日表’页面
- 如果已经存在该周的服事安排，那么点击日期就可以进入编辑页面。如果还不存在该周的服事安排，那么点击页面标题右侧绿色的“添加”按钮可以添加新的一周服事安排。
- 点击日期进入该周的编辑页面之后，点击相应行左侧的‘添加’，即可填写或编辑服事人员。
- 如果有需要添加新的服事项目，比如说新开了一组姐妹会，请联系管理员，管理员可以很简单地在后台添加。 

###如何获取服事值日表以便写周报？
- 在‘服事值日表’页面‘按日期查找’那里输入日期，点击查找，下方会出现一个文本框，如果大家已经填好，那么直接copy内容到gmail即可，务必检查内容是否齐全和正确，并在有需要的地方修改格式。

###如何获取群发邮件列表？
- 在‘小组列表’页面，点击小组名称，比如说‘周报组’，就出现该组成员的列表，最上方就是邮件列表，复制到邮箱里发邮件即可。周报组同工，弟兄姐妹会负责人，和祷告会同工可以通过这个功能获取邮件列表，发送群体邮件。

###如何查询每月过生日的人？
- 在‘联系人列表’页面中，利用生日月份搜索功能。
