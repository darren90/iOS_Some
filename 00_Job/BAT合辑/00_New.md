
## 面试题
block 实际上是，指向结构体的指针，
编译器会将block内部的代码，生成对应的函数

block 的内存，默认在栈中，不需要手动管理




## 问题答案：

## 非技术面试

### 请你做一下自我介绍    答：您好，我叫冯腾飞，毕业于XXXX，做iOS开发两年多了，之前在人人视频的做iOS开发的工作，想应聘这边的新工作 
### 你在找工作时，最重要的考虑因素是什么？
    企业文化吧，
### 为什么从上家公司离职
    想寻找大的平台或新机会，尝试在新的环境上提升自己
### 请谈谈你的优点和缺点？
    1. 优点：遇到困难迎头而上，有一股干劲
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
### 本周学习了什么
    jsbridge js和H5的交互
### CocoaPods原理
    以target的方式组成一个名为Pods的工程，该工程会生成一个名称为libPods.a的静态库，
Podfile.lock 文件就记录下了当时最新 Pods 依赖库的版本

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

    代理 单例
    观察者 ： KVO
    工厂模式
    

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


### 多线程
### 将一个函数在主线程执行的4种方法

GCD方法，通过向主线程队列发送一个block块，使block里的方法可以在主线程中执行。

	dispatch_async(dispatch_get_main_queue(), ^{      
	    //需要执行的方法
	});

NSOperation 方法

	NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];  //主队列
	NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
	    //需要执行的方法
	}];
	[mainQueue addOperation:operation];

NSThread 方法

	[self performSelector:@selector(method) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES modes:nil];
	
	[self performSelectorOnMainThread:@selector(method) withObject:nil waitUntilDone:YES];
	
	[[NSThread mainThread] performSelector:@selector(method) withObject:nil];

RunLoop方法

	[[NSRunLoop mainRunLoop] performSelector:@selector(method) withObject:nil];

### GCD的使用

    dispatch_async(dispatch_get_global_queue(0, 0), ^{ //第一个表示线程执行的优先级
    //执行耗时操作
    ……
        dispatch_async(dispatch_get_main_queue(), ^{
        //回到主线程进行UI刷新操作
        };
    };
    
当我们通过dispatch_async(globalQueue, ^{}); 这种方式去异步执行一个操作时，实际上操作系统会创建一个新的线程

    
    dispatch_group_t group = dispatch_group_create(); // 队列组
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0); // 全局并发队列
    
    dispatch_group_async(group, queue, ^{// 异步执行操作1
    
    // longTime1
    
    });
    
    dispatch_group_async(group, queue, ^{ // 异步执行操作2
    
    // longTime2
    
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
    
    // 在主线程刷新数据
    // reload Data
    });

### NSOperationQueue与 GCD 的区别?

    直接说 NSOperationQueue 相对于 GCD 的优点：
    1：可以直接取消在任务处理队列中的任务
    2：添加任务间的依赖关系

# 我的总结
    
### xib/storybard连接的对象为什么可以使用weak
    因为这个button已经放到view上了，因此只要这个View不被释放，这个button的引用计数都不会为0，因此这里可以使用weak引用

### @Property的作用
@Property是声明属性的语法，可以快速生成getter和setter放，

@synthesize等同于在.m文件中实现实例变量的get/set
@dymatic 则是表明要手动写

atomic（默认）：atomic意为操作是原子的，是线程安全的 ：只是保障setter和getter方法的访问安全 但是也不是绝对的安全比如[NSMutableArray remove]
nonatomic：nonatomic跟atomic刚好相反。表示非原子

. strong retaincount + 1
. copy：与strong类似，但区别在于实例变量是对传入对象的副本拥有所有权，而非对象本身。
. weak：在setter方法中，需要对传入的对象不进行引用计数加1的操作

### assign 与weak区别

    assign适用于基本数据类型，weak是适用于对象类型，并且是一个弱引用。
    
    assign还可以来修饰对象。那么我们为什么不用它修饰对象呢？因为被assign修饰的对象（一般编译的时候会产生警告：Assigning retained object to unsafe property; object will be released after assignment）在释放之后，指针的地址还是存在的，也就是说指针并没有被置为nil，造成野指针
    
    weak修饰的对象在释放之后，指针地址会被置为nil
### strong 与copy的区别

strong 与copy都会使引用计数加1，但strong是两个指针指向同一个内存地址，copy会在内存里拷贝一份对象，两个指针指向不同的内存地址

### Block 为什么使用 copy?
    默认情况下，block是存档在栈中，可能被随时回收，需要copy操作。这也就是我们在定义block的时候用得时copy。而不是weak等等。
    

### SEL 与 IMP 的差别？

    SEL ：通俗的讲方法名或者说方法编号
    IMP ： 函数指针，保存方法的地址

    两者关系：SEL 通过 Dispatch table表 寻找到对应的 IMP。
    struct objc_method {
      SEL method_name;
      char \*method_types;
      IMP method_imp;
    }

### 消息机制的流程
[[Student alloc] init];  
objc_msgSend(objc_msgSend(“Student” , “alloc”), “init”)

[xiaoming study];

1. xiaoming的isa指针找到obj对应的class。在class中先去cache中通过SEL查找对应函数method。
2. 若cache中未找到。再去methodList中查找，若methodlist中未找到，则去superClass中查找。若能找到，则将method加入到cache中，以方便下次查找，并通过method中的函数指针跳转到对应的函数中去执行。
3. 如果都没有找到，runtime 会调用 resolveInstanceMethod: 或 resolveClassMethod: 来给我们一次动态添加方法实现的机会。我们需要用 class_addMethod 函数完成向特定类添加特定方法实现的操作。


### 苹果是如何实现autoreleasepool的？

    autoreleasepool以一个队列数组的形式实现,主要通过下列三个函数完成.
    •    objc_autoreleasepoolPush
    •    objc_autoreleasepoolPop
    •    objc_autorelease
    看函数名就可以知道，对autorelease分别执行push、pop操作。销毁对象时执行release操作。
    
### AutoreleasePool自动释放池是什么,如何工作 ?
AutoreleasePool: 用来存储多个对象类型的指针变量

1. 自动释放池对池内对象的作用：存入池内的对象，当自动释放池被销毁时，会对池内对象全部做一次release操作
2. 对象如何加入池中：调用对象的autorelease方法
3. 自动释放池能嵌套使用吗：能

4. 自动释放池何时被销毁 ：简单的看，autorelease的"}"执行完以后。而实际情况是Autorelease对象是在当前的runloop迭代结束时释放的，而它能够释放的原因是系统在每个runloop迭代中都加入了自动释放池Push和Pop

### 一个autorealese对象在什么时刻释放？

    分两种情况：手动干预释放时机、系统自动去释放。
    
    1. 手动干预释放时机--指定autoreleasepool 就是所谓的：当前作用域大括号结束时释放。
    2. 系统自动去释放--不手动指定autoreleasepool

 
### objc使用什么机制管理对象内存？

通过引用计数器(retainCount)的机制来决定对象是否需要释放。 每次runloop完成一个循环的时候，都会检查对象的 retainCount，如果retainCount为0，说明该对象没有地方需要继续使用了，可以释放掉了

### iOS内存管理  ARC 下的内存管理问题
主要存在 循环引用（Reference Cycle）问题 --> Block内存管理

ARC所做的只不过是在代码编译时为你自动在合适的位置插入release或autorelease，只要没有强指针指向对象，对象就会被释放。


### 有哪些情况会出现内存泄漏？

block
delegate
NSTimer

### delegate 属性为什么使用 weak ?
    viewcontroller通过strong指针拥有一个UITableview，tableview的datasource和delegate都是weak指针，指向viewcontroller，防止回环
    
### 弱引用的实现原理

    弱引用的实现原理是这样，系统对于每一个有弱引用的对象，都维护一个表来记录它所有的弱引用的指针地址。这样，当一个对象的引用计数为 0 时，系统就通过这张表，找到所有的弱引用指针，继而把它们都置成 nil。

### 除了用 __weak 来解决block 中的循环引用，还有别的方法吗?
 YTKNetwork ：
 
    Controller 持有了网络请求对象
    网络请求对象持有了回调的 block
    回调的 block 里面使用了 self，所以持有了 Controller
    解决办法就是，在网络请求结束后，网络请求对象执行完 block 之后，主动释放对于 block 的持有
    
    // https://github.com/yuantiku/YTKNetwork/blob/master/YTKNetwork/YTKBaseRequest.m
    // 第 147 行：
    - (void)clearCompletionBlock {
        // 主动释放掉对于 block 的引用
        self.successCompletionBlock = nil;
        self.failureCompletionBlock = nil;
    }

？？？？

ARC 下认为可以通过提前释放 block 来解决这个问题。
通过 block 的瞬间执行，来解决这个问题，之前做的 笔记 中有记录。

### NSTimer为什么不能像block使用 weakSelf解决循环引用
首先：NSTimer的target必须要强引用
The timer maintains a strong reference to this object until it (the timer) is invalidated

###  A push到B后，有哪些方法可以让B的数据传递到A。

block、delegate、通知 KVO，或者NSUserdefault //NSUserDefaults standardUserDefaults

//NSKeyedArchiver

### frame 和 bounds 的区别，什么时候 frame 和 bounds 的高宽不相等?
frame : 相对于 父视图的坐标位置
bounds： 相对于本身的坐标系统，原点是（0， 0）点。

旋转后

### RunLoop有几种事件源？有几种模式？
Run Loop对象处理的事件源分为两种：Input sources 和 Timer sources。

Input sources：用分发异步事件，通常是用于其他线程或程序的消息。
Timer sources：用分发同步事件，通常这些事件发生在特定时间或者重复的时间间隔上(Timer事件（Schedule或者Repeat）)。

### 分类是如何实现的？它为什么会覆盖掉原来的方法？
    Category 实际上就变成了一个方法列表, 被插入到类的信息内, 这样查表的时候就能找到Category 内的方法。
    
    
    后编译

### AutoLayout做动画?

    [UIView animateWithDuration:1.0 animations:^{
        //更改约束，及约束优先级，
        [self.view layoutIfNeeded];
    }];





















---
### 

iOS 核心框架

CoreAnimation
CoreGraphics
CoreLocation
AVFoundation
Foundation
iOS核心机制

UITableView 重用
ObjC内存管理；自动释放池，ARC如何实现
runloop
runtime
Block的定义、特性、内存区域、如何实现
Responder Chain
NSOperation
GCD
数据结构

8大排序算法
二叉树实现
二分查找实现





















### iOS面试题-未解答01


### ----------------------------------第一部分--------------------------------------
 
Objective-C运行时定义了几种重要的类型。
Class：定义Objective-C类
Ivar：定义对象的实例变量，包括类型和名字。
Protocol：定义正式协议。
objc_property_t：定义属性。叫这个名字可能是为了防止和Objective-C 1.0中的用户类型冲突，那时候还没有属性。
Method：定义对象方法或类方法。这个类型提供了方法的名字（就是**选择器**）、参数数量和类型，以及返回值（这些信息合起来称为方法的**签名**），还有一个指向代码的函数指针（也就是方法的**实现**）。
SEL：定义选择器。选择器是方法名的唯一标识符。
IMP：定义方法实现。这只是一个指向某个函数的指针，该函数接受一个对象、一个选择器和一个可变长参数列表（varargs），返回一个对象



---

block指向结构体的指针，结构体的里面的值也是10，block直接防具局部变量是值传递，但是变量前面加上__block时就是地址传递
block 内存默认在栈中，不会对所引用的对象+1，如果对block进行Block_copy操作，block的内存会在堆中，会对所引用的对象进行retain操作


 

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



