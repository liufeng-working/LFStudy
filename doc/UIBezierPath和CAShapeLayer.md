# **UIBezierPath和CAShapeLayer**

[原文地址](http://www.jianshu.com/p/c5cbb5e05075)

## CAShapeLayer简单使用
在CAShapeLayer中，也可以像CALayer一样指定它的frame来画，就像这样：

```
CAShapeLayer *layer = [CAShapeLayer layer];
layer.frame = CGRectMake(110, 100, 150, 
layer.backgroundColor = [UIColor redColor].CGColor;
[self.view.layer addSublayer:layer];
```

然后就会得到一个红色的黑色矩形。

## CAShapeLayer结合UIBezierPath
CAShapeLayer有一个神奇的属性path用这个属性配合上UIBezierPath这个类就可以达到超神的效果。

UIBezierPath顾名思义，这是用贝塞尔曲线的方式来构建一段弧线，你可以用任意条弧线来组成你想要的形状。

### 画矩形
比如，你想用它来和上面一样画一个矩形，那就可以这样子来做：

```
UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(110, 100, 150, 100)];
CAShapeLayer *layer = [CAShapeLayer layer];
layer.path = path.CGPath;
layer.strokeColor = [UIColor redColor].CGColor;
layer.fillColor = [UIColor clearColor].CGColor;
[self.view.layer addSublayer:layer];
```

要注意的是，这里就不要用backgroundColor这个属性了，而要使用fillColor和strokeColor，前者代表设置这个Layer的填充色，后者代表设置它的边框色。

此时如果加上

	layer.masksToBounds = YES;
	
会发现什么都看不到了，打印

	NSLog(@"%@", NSStringFromCGRect(layer.frame));
	
就会明白发生什么，原来设置path仅仅会把对应路径的图形绘制到layer上，但layer的尺寸还是为{{0, 0}, {0, 0}}。

### 画圆角图形
在说回UIBezierPath，在UIBezierPath的类方法中，就有很多方便你画各种图形的方法，比如你可以画一个带圆角的图形:

```
UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 150, 100) cornerRadius:20];
CAShapeLayer *layer = [CAShapeLayer layer];
layer.path = path.CGPath;
layer.strokeColor = [UIColor redColor].CGColor;
layer.fillColor = [UIColor clearColor].CGColor;
[self.view.layer addSublayer:layer];
```

### 画圆
还可以指定起始角和半径画圆：

```
UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:100 startAngle:0 endAngle:2*M_PI clockwise:YES];
CAShapeLayer *layer = [CAShapeLayer layer];
layer.path = path.CGPath;
layer.strokeColor = [UIColor redColor].CGColor;
layer.fillColor = [UIColor clearColor].CGColor;
[self.view.layer addSublayer:layer];
```

### 画曲线
贝塞尔曲线的画法是由起点、终点、控制点三个参数来画的，为了解释清楚这个点，我写了几行代码来解释它:

```
CGPoint startPoint = CGPointMake(50, 300);
CGPoint endPoint = CGPointMake(300, 300);
CGPoint controlPoint = CGPointMake(170, 200);
UIBezierPath *path = [UIBezierPath bezierPath];
CAShapeLayer *layer = [CAShapeLayer layer];    
[path moveToPoint:startPoint];
[path addQuadCurveToPoint:endPoint controlPoint:controlPoint];    
layer.path = path.CGPath;
layer.fillColor = UIColor.clearColor.CGColor;
layer.strokeColor = UIColor.blackColor.CGColor;    
[self.view.layer addSublayer:layer];
```

控制点决定了它的曲率，曲线的顶点不等于控制点的位置，具体可以看一下贝塞尔曲线的定义，你还可以使用两个控制点来画。

## CAShapeLayer加强

### 动画
CAShapeLayer 是个神奇的东西，给它一个path它就能变成你想要的形状，它还有很多可以玩的地方。综合使用可以组合成不同的动画，比如下面这个例子：

```
CGPoint startPoint = CGPointMake(50, 300);
CGPoint endPoint = CGPointMake(300, 300);
CGPoint controlPoint1 = CGPointMake(170, 200);
CGPoint controlPoint2 = CGPointMake(180, 400);
UIBezierPath *path = [UIBezierPath bezierPath];
CAShapeLayer *layer = [CAShapeLayer layer];
[path moveToPoint:startPoint];
[path addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
layer.path = path.CGPath;
layer.fillColor = UIColor.clearColor.CGColor;
layer.strokeColor = UIColor.blackColor.CGColor;
layer.strokeStart = 0.5;
layer.strokeEnd = 0.5;
[self.view.layer addSublayer:layer];
    
CABasicAnimation *start = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
start.toValue = @0;
start.duration = 1;
start.autoreverses = YES;
start.repeatCount = MAXFLOAT;
[layer addAnimation:start forKey:nil];
    
CABasicAnimation *end = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
end.toValue = @1;
end.duration = 1;
end.autoreverses = YES;
end.repeatCount = MAXFLOAT;
[layer addAnimation:end forKey:nil];
```

## 结语
使用UIbezierPath和CAShapeLayer可以画出你想要的任何形状，没有它做不到，只有你想不到，搞定了它们你就可以轻松定制你想要的任何控件了。