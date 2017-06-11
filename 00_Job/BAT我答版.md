## [3月份网易阿里百度iOS实习面试题](http://linlexus.com/interview_problem_for_ali_baidu_netease/)

### Cocoa 有哪些消息传递机制？
KVO，代理，通知，block

## 谈谈Swift和Objective-C的优缺点

OC优点:
	
1. Category类别
2. 动态识别
3. 易读

OC缺点：

1. 不支持命名空间
2. 不支持多重继承
 
Swift优点：

1. 类型安全

Swift缺点：  

1. 目前还不稳定，变动较大

### n 的阶乘末尾有几个0？
和5的个数相关
### Block里引用到self的话一定要用weak self吗？
1. 只有当block直接或间接的被self持有时，才需要weak self。
2. 结束的时候，调用了这个方法把block置空，就打破了循环引用
### UIView在什么时候会调用drawRect
1. 设置frame后
2. setNeedsDisplay
3. sizeToFit
### 调用setNeedsDisplay后，视图会立刻刷新吗
setNeedsLayout

标记为需要重新布局，不立即刷新，会默认调用layoutSubviews。

layoutIfNeeded

如果，有需要刷新的标记，立即调用layoutSubviews进行布局

setNeedsDisplay

setNeedsDisplay会自动调用drawRect方法，这样可以拿到 UIGraphicsGetCurrentContext，就可以进行绘制了。

### iOS如何取消一个网络请求
用NSURLSessionDataTask的cancel方法

### 如何让 Category 支持属性？

通过runtime.h中objc_getAssociatedObject / objc_setAssociatedObject来访问和生成关联对象。通过这种方法来模拟生成属性。


	// 定义关联的key
	static const char *key = "name";
	- (NSString *)name
	{
	    // 根据关联的key，获取关联的值。
	    return objc_getAssociatedObject(self, key);
	}
	- (void)setName:(NSString *)name
	{
	    // 第一个参数：给哪个对象添加关联
	    // 第二个参数：关联的key，通过这个key获取
	    // 第三个参数：关联的value
	    // 第四个参数:关联的策略
	    objc_setAssociatedObject(self, key, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	
### 的	













