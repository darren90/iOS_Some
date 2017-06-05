
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

??????

### 多线程有几种方式？你用过没有？你经常用哪种？怎么用的？


### 消息转发内部原理（结构指针，方法选择器，forwarding...一串破玩意儿）--百度


### 堆和栈的内存区别，它们是如何分配和释放
栈区（stack） ：由编译器自动分配并释放
堆区（heap）：由程序员分配和释放，是由alloc分配

### 线程间通信常用的方法
    - (void)performSelectorOnMainThread:(SEL)aSelector withObject:(nullable id)arg waitUntilDone:(BOOL)wait;

    - (void)performSelector:(SEL)aSelector onThread:(NSThread *)thr withObject:(nullable id)arg waitUntilDone:(BOOL)wait NS_AVAILABLE(10_5, 2_0);

### 用NSOpertion和NSOpertionQueue处理A、B、C三个线程，要求执行完A、B后才能执行C，怎么做？


    //1. 创建队列
    NSOperationQueue *queue = [[NSOpertionQueue alloc] init];
    
    //2. 创建3个操作
    NSOperation *a = [NSOperation blockOperationWithBlock:^{
    NSLog(@"operation---");
    }];
    NSOperation *b = [NSOperation blockOperationWithBlock:^{
    NSLog(@"operation---");
    }];
    NSOperation *c = [NSOperation blockOperationWithBlock:^{
    NSLog(@"operation---");
    }];
    
    //3. 添加依赖
    [c addDependency:a];
    [c addDependency:b];
    
    //4. 执行操作
    [queue addOperation:a];
    [queue addOperation:b];
    [queue addOperation:c];

### 线程是进程的基本组成单位


### 如何处理图片拉伸问题?

	创建可拉伸的图片对象
	bg = [bg resizableImageWithCapInsets:UIEdgeInsetsMake(10,10,10,10) resizingMode:..];//平铺和拉伸
	UIImage *bg = ...




### 在xcode中如何配置拉伸图片?

在Xcassets中-->选中图片—->右边(Slicing)—>Sices:Horizontal and Vertical —>上下左右设置


### 请简单说明如何简单的解决多线程访问同一块资源造成的线程安全的问题，以及注意点？

	加同步(互斥)锁，
	@synchronized
	OC中的同步锁:(锁对象) + {要锁住的代码}
	锁对象:要求是全局唯一的属性
	注意点:
	1.要注意加锁的位置
	2.加锁需要耗费性能,因此需要注意加锁的条件(多线程访问同一块资源)
	3.专业术语:线程同步


###请简单介绍下什么是原子和非原子属性？

	atomic：原子属性，会为setter方法加锁，默认为atomic。线程安全，会消耗大量资源
	nonatomic：非原子属性，不会为setter方法加锁。非线程安全，适合内存小的移动设备。


### 请简单介绍下GCD这门技术？

	全称 Grand Central Dispatch，牛逼的中枢调度器。
	GCD中有2个核心概念:任务和队列。
### 请简单介绍GCD中的几种队列？（4种）
	
	并发队列：多个任务同时执行，会开启多个线程同时执行任务，只有在异步函数下才有效。
	串行队列：任务只能一个接一个的去执行，不会开启多个线程，主队列属于串行队列，主队列所有的任务必须在主线程中执行。
	
	全局队列
	
	主队列
### 如果当前有多个任务，这些任务都需要开子线程执行，而多个任务之间有一定的依赖关系，如果使用GCD来实现请试着给出一些解决方案。

	使用异步函数（同步函数）+主队列


### 请简单介绍操作队列？

	操作队列本身是OC语言的，在iOS开发中可以用来实现多线程编程
	
	操作队列有两大核心的概念，一个是操作（NSOperation），一个是队列(NSOperationQueue),操作用来封装任务，队列用来存放操作
	
	要使用操作队列进行多线程编程，只需要把封装好的操作提交到相应的队列中即可，系统内部会视情况自动开启相应的线程来执行任务
	
	在操作队列这门技术中，系统提供了两个子类可以来封装任务，一个是NSInvocationOperation，一个是NSBlockOperation,除此之外也可以直接自定义操作
	
	操作队列中有两种队列，一种是通过[NSOperationQueue mainQueue]获得的主队列，一种是通过[[NSOperationQueue alloc]init]方法获得的非主队列
	
	主队列是和主线程相关的串行队列，提交到主队列中的操作将被安排在主线程中执行（可以利用该特性来处理线程间通信的相关逻辑）
	
	操作+队列:
	
	NSInvocationOperation
	
	NSBlockOperatio
	
	NSOperationQueue
	
	自己创建 [[NSOperationQueue alloc]init];
	
	主队列 [NSOperationQueue main];

### 如果有多个操作如何来设置依赖关系，如何监听到某个操作执行完毕事件？

	1.设置依赖关系：假设有有两个操作分别是op1和op2，op1需要依赖于op2,那么只需要使用[op1 addDependency:op2]方法设置即可。
	
	2.操作依赖补充：使用操作队列可以方便的指定多个操作间的依赖关系，甚至可以实现跨队列的操作依赖，但是在使用的时候需要注意操作之间不能有循环依赖关系
	
	3.操作监听：可以使用^completionBlock来实现操作监听


### 请简单比较GCD中的全局并发队列和使用dispatch_queue_create函数创建的并发队列异同？

	1.全局并发队列在整个应用程序中本身是默认存在的并且对应有高优先级、默认优先级、低优先级和后台优先级一共四个并发队列，我们只是选择其中的一个直接拿来用。而Create函数是实打实的从头开始去创建一个队列。
	
	2.在iOS6.0之前，在GCD中凡是使用了带Create和retain的函数在最后都需要做一次release操作。而主队列和全局并发队列不需要我们手动release。当然了，在iOS6.0之后GCD已经被纳入到了ARC的内存管理范畴中，即便是使用retain或者create函数创建的对象也不再需要开发人员手动释放，我们像对待普通OC对象一样对待GCD就OK。

### 在进行多线程编程的时候相对于GCD而言，操作队列有哪些优势？

	NSOperation和NSOperationQueue的好处有：
	
	1.NSOperationQueue可以方便的调用cancel方法来取消某个操作，而GCD中的任务是无法被取消的（安排好任务之后就不管了）。
	
	2.NSOperation可以方便的指定操作间的依赖关系。
	
	3.NSOperation可以通过KVO提供对NSOperation对象的精细控制（如监听当前操作是否被取消或是否已经完成等）
	
	4.NSOperation可以方便的指定操作优先级。操作优先级表示此操作与队列中其它操作之间的优先关系，优先级高的操作先执行，优先级低的后执行。
	
	5.通过自定义NSOperation的子类可以实现操作重用

### 简单介绍GCD中的一次性代码?

1.一次性代码：

	   static dispatch_once_t onceToken;
	     dispatch_once(&onceToken, ^{
	        NSLog(@"-------");
	     });
     
2.特点：

  - 在整个程序运行过程中block中的代码只会被执行一次
  - 一次性代码本身是线程安全的

3.常用于单例模式的实现中

### GCD中的dispatch_after是延迟把任务提交到队列还是先提交到队列再延迟执行？

	是延迟之后在把任务提交到队列执行，把任务提交到队列中在延迟执行难度较大，不容易实现.

### 请说明NSRunloop和线程的关系?

	线程和runloop是一一对应的关系(字典)
	
	主线程对应的runloop是默认创建并启动的
	
	子线程对应的runloop需要手动的创建并启动
	
	如何获得子线程对应的runloop?[NSRunloop currentRunloop]该方法是懒加载的,在第一次调用该方法的时候发现该子线程对应的runloop不存在则会直接创建一个runloop保存并且返回.
	
	线程销毁后runloop也要销毁

### 请简单说明runloop中几个类之间的相互关系（runloop & source & timer &observer &mode）

	runloop启动之后会选择一种运行模式，在执行执行会先检查运行模式内部是否有source和timers,如果一个sourc或者是一个timer都没有那么runlooop启动之后就立刻退出了。
	
	runlooop的source有两种分类方法，按照以前的分类方法可以分为
	
	基于端口的
	
	自定义的
	
	performSelector事件
	
	按照函数调用栈来划分，可以分为source0和soucr1。
	
	observer，可以用来监听当前runloop运行状态的改变，注意（Core foundation框架）
	
	NSTimer必须添加到runloop中才会工作，且其工作收到runloop运行模式的影响


### 请问SDWebImage框架内部在清理磁盘缓存的时候clearDisk方法和cleanDisk方法有什么区别？

	clearDisk:直接把整个缓存文件删除，删除之后创建一个新的空文件;

	cleanDisk:先删除过期的缓存文件，然后计算当前剩余缓存文件的大小,如果该数值超过设定的最大缓存大小，那么久安全文件创建的时间从远到近依次删除，直到整个剩余缓存文件大小小于设定的最大缓存大小为止。

### 请问SDWebImage框架的框架结构是怎么样的？

	SDWebImage框架有几个主要的组件：
	
	管理者（SDWebImageManager)
	
	缓存处理组件（SDImageCache）主要对下载的图片进行内存缓存和磁盘缓存处理
	
	下载处理组件（SDWebImageDownloader|SDWebImageDownloadOperation）主要处理开子线程异步发送网络请求下载图片相关操作

### 请简单说明HTTP通信的过程？

	1.请求：如果客户端想要获得相应的数据，那么就对着服务器发送一个请求，请求是客户端向服务器索要数据的过程。
	
	2.响应：服务器接收到客户端的请求之后，需要对该请求作出反应，响应是服务器端把数据返回给客户端的过程。
	
	3.请求分为两部分，一个是请求头，一个是请求体（GET请求没有请求体）。其中请求头是对客户端信息和请求本身的描述，而请求体存放要发送给服务器端的具体数据
	
	4.响应分为两部分，一个是响应头，一个是响应体。其中响应头是对服务器端信息和响应数据本身的描述，而响应体存放要发送给客户端的具体数据。
	
### 请简单说明NSURLSession对比NSURLConnection的优势？

	NSURLSession支持http2.0协议(iOS 9.0 +)
	
	在处理下载任务的时候可以直接把数据下载到磁盘
	
	支持后台下载|上传
	
	同一个session发送多个请求，只需要建立一次连接（复用了TCP）
	
	提供了全局的session并且可以统一配置，使用更加方便
	
	下载的时候是多线程异步处理的效率更高

### 请简单说明什么是序列化和反序列处理，用到了什么方法？

	反序列化处理，即把JSON数据—->OC对象，使用的方法为：[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil]
	
	序列化处理，即把OC对象—->JSON数据，使用的方法为：[NSJSONSerialization dataWithJSONObject:jsonString options:0 error:nil],注意并不是所有的OC对象都能够序列化为JSON数据































---

(*个数越多代表越重要)
一、Objective-C
1.内存管理（***）
2.KVC\KVO（***）
3.runtime（***）

二、iOS
1.多线程、网络（***）
2.控制器view的生命周期（***）
* viewDidLoad
* ....
* didReceiveMemoryWarning
3.事件处理（**）
4.核心动画（**）
5.Quartz2D绘图（**）
6.UITableView的性能优化（循环利用机制，***）
7.app的完整启动过程（***）



