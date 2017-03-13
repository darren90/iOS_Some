# 前言

今天某某提供的一份面试题，笔者看了看，还是整理一下，分享给大家吧。对于新手、刚出来找工作的或者准备要面临找工作的小伙伴们来说，笔者所提供的参考答案一定会有帮助的。

有一些人私聊我说：“天天分享这些东西有什么目的？对你有什么好处？”。我想说一句，分享的目的就是提升自己的同时帮助他人少走弯路。听到这样的话，心里既不痛快却又暗暗欢喜。喜之有人妒忌，不痛快之总有人以自我为中心而非大我！

请珍惜阅读笔者所分享的每一篇文章，那都是笔者一个字一个字的打出来的，而且还是经过大脑整理一遍又一遍的，我最大的收获就是吸引了这些知识！

# 题照

![image](http://101.200.209.244/wp-content/uploads/2016/03/interview.jpg)

# 1、#import和#include的区别，@class代表什么？

**参考答案：**

这里老生常谈的问题了！\#import和\#include指令都是用于包含头文件的，前者是保证只会包含一次，不会重复包含；后者是c语言中原来就有的包含头文件的指令，在objc开发中，若是c文件，一件会使用\#include指令来包含头文件，为了防止重复包含，通常会加上条件编译，如：

```
// 随手写的例子
// 若已经定义过则不再定义之，这是防止重复包含的手段
#ifndef __HYB__GRIDVIEWCONTROLLER__

#define kScreenWidth ...

#endif
```

@class是类前向声明的指令，相当于告诉编译器有这样一个类，但是类的定义在后面提供。在编译时期，编译器看到@class指令声明了对应的类型，是可以正常编译过的。这是很常用的指令，主要是防止循环引用。

如果有循环依赖关系，如:A–>B, B–>A这样的相互依赖关系，如果使用\#import来相互包含，那么就会出现编译错误，如果使用@class在两个类的头文件中相互声明，则不会有编译错误出现。

# 2、谈谈Objective-C的内存管理方式及过程

**参考答案：**

对于Objective-C，在MRC下内存是手动管理的，而在ARC下，我们不用手动去添加retain/release，但是其内存管理法则是一样的。

内存管理黄金法则：谁使对象的引用计数+1，谁就负责管理使该对象的引用计数-1。

说说内存管理的过程：

在MRC下，对于需要手动释放的对象的内存管理，我们通过release使对象引用计数-1，若其引用计数变成0，则对象会被立刻释放掉。对于autorelease交给自动释放池管理的对象，每个runloop循环结束就会去自动释放池中使所有autorelease类型对象的引用计数减一，若变成0，则释放之。

在ARC下，我们没有不能直接调用retain/release来管理释放，都是交给自动释放池来管理的。因此，若创建临时变量，想要使用完就释放之，需要在临时变量放到新创建的自动释放池里，这样就可以使用完后就到达了自动释放池的一个循环，就会去使对象引用计数减一，变成0后释放之。

最后：对于交给自动释放池管理的对象，是在每个run loop事件循环结束时才会去使对象引用计数减一，此时引用计数为0的才会得到释放。

# 3、Objective-C有私有方法吗？私有变量呢？

**参考答案：**

在Objective-C中，没有实实存在的私有方法。通常所谓的私有方法就是放在.m文件中声明和实现，外部不能直接看到而已，但是若我们知道有这么一个API，我们是可以调用的。比如，在苹果上架会因为使用了苹果的所谓的私有API而被拒，而这个所谓的私有API就是指苹果没有公开出来，但是我们通过其它方式可以看到苹果的内部有这样一个API可以实现某些不公开的功能。

私有变量是有的，可以通过@private来声明私有变量。比如：

```
@interface HYBTestModel: NSObject {
  @private NSString *_privateName;
}
```

如果我们没有使用@private声明，它是受保护的，外部也不能直接通过对象给变量赋值：

```
// error
testModel->_privateName = @"报错了，提示成员变量是受保护的";
```

**但是**，所谓的私有变量也不是绝对不能访问的，通过runtime或者KVC是可以获取或者修改值的。

# 4、Objective-C有多继承吗？没有的话用什么代替？Cocoa中所有的类都是NSObject的子类？

**参考答案：**


Objective-C没有多继承，这是去掉C++中多继承的特性，改成使用protocol来代替。Cocoa中所有的类不都是NSObject的子类，还有部分继续于NSProxy的（可用于实现动态代理）。绝大部分根类是NSOjbect，它元类的isa指针指向的是NSObject。参考下图：

![image](http://101.200.209.244/wp-content/uploads/2015/12/inherit.png)


# 5、浅拷贝与深拷贝的区别是什么

**参考答案：**

用最简单的话说：浅拷贝就是指针拷贝（指向原有内存空间），而深拷贝是内容拷贝（有新的内存空间）。

或者说：浅复制并不拷贝对象本身而仅仅是拷贝指向对象的指针；深复制是直接拷贝整个对象内存到另一块内存中。

更详细地可以阅读这篇文章：[iOS深拷贝与浅拷贝](http://www.henishuo.com/ios-shadowcopy-deepcopy/)

# 6、属性readwrite、readonly、assign、retain、copy、nonatomic各是什么作用，在哪种情况下用？

**参考答案：**

作用分别是：

* readwrite：代表可读可写，会生成getter和setter方法
* readonly：代表只读，只生成getter方法，不会生成setter方法
* assign：代表普通赋值，通常用于非对象类型，MRC下对于弱引用也使用assign，ARC下弱引用通常使用weak
* retain：MRC下才能手动使用，与ARC下的strong一样，指定强引用，引用计数加1
* copy：代表拷贝，也是强引用，引用计数加1，进行指针拷贝
* nonatomic：代表非原子操作，非线程安全，但可提高性能，通常声明属性时都会添加

在哪种情况使用：

* readwrite：默认就是，通过不用显示指定，需要生成setter和getter时使用
* readonly：当不希望生成setter时使用
* assign：通常是非对象类型使用
* retain：MRC下才能使用，表示对象强引用
* copy：生成不可变对象、需要拷贝时使用
* nonatomic：不要求线程安全时使用，可提高性能，通常都会使用

# 7、常见的objective-c的数据类型有哪些，和C的基本数据类型有什么区别？

**参考答案：**

常见数据类型：NSData、NSArray、NSDictionary、NSSet、NSCountedSet、NSNumber、NSInteger、NSUInteger、所有基本C数据类型，当然还有对应可变的类型。

有什么区别：对象类型在C中全没有。然后基本类型是所有的C的基本类型，当然oc还提供了NSNumber这个类来处理所有的基本C类型。

# 8、描述iOS SDK中如何实现MVC的开发模式

**参考答案：**

这使用MVC的开发模式与是不是SDK没有关系，即使是SDK，如果有Model、View、Controller，那么就可以通过MVC模式来开发。

笔者真不知道这道题的本质是不是想问如何开发iOS SDK？如何使用MVC？

# 9、什么时候使用NSMutableArray，什么时候使用NSArray？

**参考答案：**

原则上对外返回的数据都应该是NSArray类型，防止外部操作内容的数据，提供只读不可写的操作。NSMutableArray与NSArray的区别在于，前者是可以有增、删、改操作的，但是后者在初始化之后就只有读操作。如果不要求增、删、改操作，原则上直接使用NSArray即可；反之都使用NSMutableArray。

# 10、给出委托方法的实例，并且说出UITableView的DataSource方法

**参考答案：**

这给出委托的实例是很简单，但是后面要说出DataSource的方法，这是有点脑残了，除了required这两个方法，其它怎么会记得全~

随手写一个：

```
@protocol HYBTestCellDelegate <NSObject>

- (void)fuckInterviewerWithSBMessage:(NSString *)sbInterviewMessage;

@end

@interface HYBTestCell: NSObject 

@property (nonatomic, weak) id<HYBTestCellDelegate> delegate

@end
```

然后我们在控制器中调用的时候，设置了代理:

```
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  HYBTestCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
  
  HYBTestModel *model = [self.datasource objectAtIndex:indexPath.row];
  
  cell.delegate = self;
  
  return cell;
}

#pragma mark - HYBTestCellDelegate
- (void)fuckInterviewerWithSBMessage:(NSString *)sbInterviewMessage {
  NSLog(sbInterviewMessage);
}
```

至于后面的datasource的方法，记住这两个required的就行了：

```
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
```

如果面试官再问其它的，那你可以走了~

#最后

本来不想整理的，看着再过10多天，就要离开北京，去深圳稳定发展了，也当是给自己提前积累多一些吧！题目来源于某某人（面试者）！

今天温习了一下之前整理的东西，同时也修正部分内容！







