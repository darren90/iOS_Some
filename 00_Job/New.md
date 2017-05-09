
## 面试题
block 实际上是，指向结构体的指针，
编译器会将block内部的代码，生成对应的函数

block 的内存，默认在栈中，不需要手动管理




## 问题答案：

## 非技术面试

### 请你做一下自我介绍答：您好，我叫冯腾飞，毕业于兰州理工大学计算机专业，做iOS开发两年多了，之前在人人视频的做iOS开发的工作，想应聘这边的新工作 
### 你在找工作时，最重要的考虑因素是什么？
企业文化吧，
### 为什么从上家公司离职
想寻找大的平台或新机会，尝试在新的环境上提升自己
### 请谈谈你的优点和缺点？
1. 优点：遇到困难迎头而上，
2. 缺点：不太自信，平时的社交少,缺少锻炼
### 工作中曾面临的最大困难是什么？如何解决的？  公司的项目中遇到什么问题没
1. 播放器的自定义，以及大小屏幕：公司转型做视频相关的时候，没有做过相关的经验，显示找了一些源码，给你点信息以及思路，再就是自己给自己加班，放的经历多了，自然就解决了
2. 下载：片源的类型比较多，
### 你的职业目标是什么？（短期和长期）
短期：React Native的学习与引用
长期：提供技术实力，向技术leader的方向看起
### 你对加班的看法？
还好，大家都是为了把产品做好，加班把项目保质保量的完工都能接受，
### 你最擅长的技术方向是什么？谈谈你之前做的项目？
### 你有什么问题要问我？
1. 我想了解一下公司的培训机制和学习
2. 公司对我这个职位的期望是什么？
3. 问问公司内部的培养计划、晋升机制、是否经常有大牛分享技术让我们学习




## 技术面试

### 什么事离幕渲染
指的是GPU在当前屏幕缓冲区以外新开辟一个缓冲区进行渲染操作。
shouldRasterize（光栅化）
masks（遮罩）
shadows（阴影）
edge antialiasing（抗锯齿）
group opacity（不透明）
复杂形状设置圆角等
渐变

 
### 你技术上是怎么学习的？
1. 博哥关注了几个牛人的博客
2. Github
3. 多联系
 

--- 

### 让自己实现下拉控件，如何实现。
scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height
scrollView.contentOffset.y < - 100


### 什么是响应链，它是怎么工作的？
传递链：由系统向离用户最近的view传递。UIKit –> active app’s event queue –> window –> root view –>……–>lowest view
响应链：由离用户最近的view向系统传递。initial view –> super view –> …..–> view controller –> window –> Application

###### 事件的传递
触摸事件的传递是从父控件传递到子控件
也就是UIApplication->window->寻找处理事件最合适的view
注 意: 如果父控件不能接受触摸事件，那么子控件就不可能接收到触摸事件


### 访问并修改一个类的私有属性

方法一:KVC  [p setValue:@"yyMae" forKey:@"name"];
方法二:通过runtime获取  object_setIvar(Person, name, @"yyMae"); 


### 什么时候会发生 `EXC BAD ACCESS` 异常
因为内存问题引起： 指针指向内存中的某个地址，但对应的地址块已经被回收,如对已经被release的对象发送release消息。


### 你会如何存储用户的一些敏感信息，如登录的 token
使用keychain来存储,也就是钥匙串。 使用keychain需要导入Security框架。



### `+load` 和 `+initialize` 的区别是什么？

load和initialize方法都会在实例化对象之前调用，以main函数为分水岭，前者在main函数之前调用，后者在之后调用。这两个方法会被自动调用，不能手动调用它们。
load和initialize方法都不用显示的调用父类的方法而是自动调用，即使子类没有initialize方法也会调用父类的方法，而load方法则不会调用父类。
load方法通常用来进行Method Swizzle，initialize方法一般用于初始化全局变量或静态变量。
load和initialize方法内部使用了锁，因此它们是线程安全的。实现时要尽可能保持简单，避免阻塞线程，不要再使用锁。




### iOS Extension 是什么？能列举几个常用的 Extension 么？
Extension是Category的一个特例，没有分类名字，可以扩展属性,成员变量和方法。

常用的扩展是在.m文件中声明私有属性和方法，基本上我们天天都在用。

### 开发中用到的设计模式








