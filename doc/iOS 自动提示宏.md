# **iOS 自动提示宏**
[原文地址](http://www.jianshu.com/p/e9d393a07496)

当我们使用KVO监听属性的时候, 属性必须要写对,但是这个属性没有提示。所以我们想要写一个自动的提示宏来保证这个属性可以写对。

	[redView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
	


首先我们写这个宏之前先要学习一下逗号表达式，只取逗号最后一个值。

 	int a = (5,2,1);
 	NSLog(@"%d", a); // 打印的结果a=1
 	
但是上面的写法会报警告Expression result unused，意思是说有个结果没有用到，但不影响结果。消除警告我们可以这样写，前面添加void,表示我不用你。

	int a = ((void)5,(void)2,1);
	NSLog(@"%d", a);
	
所以这个宏我们可以这样写：由于逗号表达式，所以这个宏，返回的只是逗号后面的内容keyPath，逗号前面的内容可以随便写。而逗号前面的我们怎么写都不影响返回值，但是为了可以使我们写frame时有自动提示，所以逗号前面我们最好写objc.keyPath，这样宏就有了自动联想功能。

	#define keyPath(objc, keyPath) ((void)objc.keyPath, keyPath)
	
这样我们就可以这样使用了keyPath(redView, frame)，这样返回的就是frame文本，但是我们需要的是@"frame"的OC字符串。

这里再介绍一点：宏里面的#号和##号的作用。在宏里面, ##的作用:连接2个标识符。

	define method(name) - (void)load##name {}
	method(abc)  //- (void)loadabc {}
	method(ddd)  //- (void)loadddd {}
	method(ttt)  //- (void)loadttt {}
	
在宏里面，#的作用:给右边的标识符加上双引号""。

	define test(name) @#name
	test(abc) // @"abc"
	
所以我们按照下面这样写:

	define keyPath(objc, keyPath) ((void)objc.keyPath, #keyPath)
	NSLog(@"%s",keyPath(redView, frame)); 结果为: "frame"

然而我们需要的是@"frame"这样的格式，我们的操作还没有完，所以我们只需要将C语言的字符串转成OC字符串即可，我们只要将C语言的字符串用@()包裹，转变成对象，即为OC字符串了。

	char *c = "abc";
	NSLog(@"%@", @(c));
	
所以最终我们的宏写成这样：

	define keyPath(objc, keyPath) @(((void)objc.keyPath, #keyPath))
	
所以开头我们的KVO监听属性就可以这样写了：

	[redView addObserver:self forKeyPath:keyPath(redView, frame) options:NSKeyValueObservingOptionNew context:nil];
	
模仿上面，我们可以写出这样的提示宏：

	#define kClassName(className) ((void)[className isKindOfClass:[NSObject class]], @#className)
	
上面这个宏的作用是，让你输入的内容必须是一个类名；类似的提示宏，可以根据自己的需求写上对应的限定条件即可。