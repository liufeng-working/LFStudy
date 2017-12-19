# **CALayer及其子类**
#[原文地址](http://www.jianshu.com/p/98ff8012362a)
> # CALayer

首先，CALayer其实自身有很多情况下自带隐式动画，但是需要注意的是UIView的根Layer是没有隐式动画的。

| 属性 | 介绍 | 隐式动画 |
| :-: | :--: | :----: |
| bounds | 图层大小 | 支持 |
| position | 图层位置 | 支持 |
| zPosition | 图层纵向位置 | 支持 |
| anchorPoint | 锚点 | 支持 |
| transform | 形变 | 支持 |
| frame | 图层大小和位置（一般用position和bounds代替） | 不支持 |
| hidden | 是否隐藏 | 支持 |
| doubleSided | 图层背面是否显示 | 不支持 |
| superlayer | 父图层 | 支持 |
| sublayers | 子图层 | 支持 |
| sublayerTransform | 子图层形变 | 支持 |
| mask | 遮罩 | 支持 |
| masksToBounds | 是否裁剪超出图层的地方 | 支持 |
| contents | 显示内容 | 支持 |
| contentsRect | 图层显示内容的位置和大小 | 支持 |
| backgroundColor | 背景色 | 支持 |
| cornerRadius | 圆角半径 | 支持 |
| borderWidth | 边框宽度 | 支持 |
| borderColor | 边框颜色 | 支持 |
| opacity | 透明度 | 支持 |
| shadowColor | 阴影颜色 | 支持 |
| shadowOpacity | 阴影透明度 | 支持 |
| shadowOffset | 阴影偏移量 | 支持 |
| shadowRadius | 阴影模糊半径 | 支持 |
| shadowPath | 阴影形状 | 支持 |

上表大致说明了CALayer的几个重要属性的作用以及是否支持隐式动画，下面着重介绍几个点：

### frame属性
frame不支持隐式动画，所以通常使用bounds和position来设置layer的位置和大小

### contents
设置layer的contents可以为layer添加显示内容，最直接的便是将UIImage转化为CGImageRef赋值，其与backgroundColor的关系就相当于UIImageView的image和backgorundColor的关系。

### 锚点anchorPoint
锚点的取值范围为（0～1，0～1），标示此点相对于宽高的比例，默认点（0.5，0.5），锚点的位置对图层的位置以及某些动画的中心起到决定性的作用，通过锚点计算图层位置-->中心点相对于父父层的位置永远不变，锚点于中心点重合。以旋转动画为例，锚点是旋转的中心。

### mask
mask的作用就相当于PS中的蒙版，在一些图层处理上具有很大的优势（注：蒙版透明色为过滤掉指定layer的区域内容，不透明色为显示制定图层的区域内容）

> # CALayer的子类

## CAShapeLayer
看一下CAShapeLayer相对于CALayer多出来的属性:

### path
CAShapeLayer的path属性是他如此牛逼的一个重要起点，也是它和贝塞尔曲线紧密连接的一个入口，他决定了我们要在图层上画一个什么形状。（注：当与贝塞尔曲线一起使用的时候，生成的曲线的位置是相对于生成的layer的，所以当你利用贝塞尔曲线设置了path后，再设置layer的position和bounds你会感觉很奇怪，最简单的方式就是单纯利用贝塞尔曲线决定图层的位置和大小）。

### fillColor和fillRule
fillColor即layer的path的填充颜色，fillRule属性用于指定使用哪一种算法去判断画布上的某区域是否属于该图形“内部” （内部区域将被填充）。对一个简单的无交叉的路径，哪块区域是“内部” 是很直观清除的。但是，对一个复杂的路径，比如自相交或者一个子路径包围另一个子路径，“内部”的理解就不那么明了。fillRule提供两种选项用于指定如何判断图形的内部”kCAFillRuleNonZero,kCAFillRuleEvenOdd。

* kCAFillRuleNonZero  
字面意思是“非零”。按该规则，要判断一个点是否在图形内，从该点作任意方向的一条射线，然后检测射线与图形路径的交点情况。从0开始计数，路径从左向右穿过射线则计数加1，从右向左穿过射线则计数减1。得出计数结果后，如果结果是0，则认为点在图形外部，否则认为在内部。

* kCAFillRuleEvenOdd  
字面意思是“奇偶”。按该规则，要判断一个点是否在图形内，从该点作任意方向的一条射线，然后检测射线与图形路径的交点的数量。如果结果是奇数则认为点在内部，是偶数则认为点在外部。下图演示了kCAFillRuleEvenOdd 规则：

### strokeColor
线颜色

### strokeStart strokeEnd
两者的取值都是0～1，决定贝塞尔曲线的划线百分比，对应值的改变支持隐式动画。

### lineWidth
线宽

### lineJoin
连接点类型，也就是对应曲线节点的位置的显示样式。

### miterLimit
最大斜接长度，只有lineJoin属性为kCALineJoinMiter时miterLimit才有效，当衔接角度太小时，斜接长度就会很大，如果设置了miterLimit并且当斜接长度大于这个值时，便会对应裁切掉多余区域。

### lineCap
线端点类型，也就是对应曲线结束的点的显示样式。

### lineDashPattern
虚线设置，为一个数组，数组中奇数为实线长度，偶数为空白长度（注意：这里的奇数，偶数以数组的第一个元素索引为1计算）

### lineDashPhase
实线开始的位置，可以使用此属性做一个滚动的虚线框。

## CAGradientLayer
下面再说一个比较常用的子类CAGradientLayer，我们一般使用它生成平滑的颜色过渡。大致的效果如下：
![渐变效果](http://ot22ho57o.bkt.clouddn.com/4408163-3b7fb21570ba757b.png)

我们还是从它的特有属性入手：

### colors
在Layer中显示的几种颜色并完成完美过渡，和CAShapeLayer的path一样，colors是CAGradientLayer特殊属性的起点，也就是x显示的要素。

### locations
颜色区间分布比例，默认为线性均匀分布。取值范围为0～1递增，一般来说其中的元素个数应与colors中的元素个数相同，不同时系统会自行处理分布规则。设置 gradientLayer.locations = @[@(0.3),@(0.7)];
![locations](http://ot22ho57o.bkt.clouddn.com/4408163-067635b18d809b8a.png.jpeg)

### startPoint endPoint
startPoint决定了变色范围的起始点，endPoint决定了变色范围的结束点，两者的连线决定变色的趋势：
![startPoint endPoint](http://ot22ho57o.bkt.clouddn.com/4408163-54c571104132078f.png.jpeg)

**注意**：locations是相对于startPoint和endPoint的变化范围而言的。

## CAEmitterLayer

### emitterCells
装着CAEmitterCell对象的数组，被用于把粒子投放到layer上

### birthRate
粒子产生系数，默认1.0

### lifetime
粒子生命周期

### emitterPosition
发射位置

### emitterZposition
发射源的z坐标位置

### emitterSize
发射源的尺寸大小

### preservesDepth
不是多很清楚（粒子是平展在层上）

### emitterDepth
决定粒子形状的深度联系

### emitterShape
发射源的形状：

	NSString * const kCAEmitterLayerPoint;
	NSString * const kCAEmitterLayerLine;
	NSString * const kCAEmitterLayerRectangle;
	NSString * const kCAEmitterLayerCuboid;
	NSString * const kCAEmitterLayerCircle;
	NSString * const kCAEmitterLayerSphere;

### emitterMode
发射模式

	NSString * const kCAEmitterLayerPoints;
	NSString * const kCAEmitterLayerOutline;
	NSString * const kCAEmitterLayerSurface;
	NSString * const kCAEmitterLayerVolume;

### renderMode
渲染模式

	NSString * const kCAEmitterLayerUnordered;
	NSString * const kCAEmitterLayerOldestFirst;
	NSString * const kCAEmitterLayerOldestLast;
	NSString * const kCAEmitterLayerBackToFront;
	NSString * const kCAEmitterLayerAdditive;

### velocity
粒子速度

### scale
粒子的缩放比例

### spin
自旋转速度

### seed
用于初始化随机数产生的种子

### CAEmitterCell属性介绍
CAEmitterCell类代表从CAEmitterLayer射出的粒子；emitter cell定义了粒子发射的方向。

#### alphaRange
一个粒子的颜色alpha能改变的范围

#### alphaSpeed
粒子透明度在生命周期内的改变速度

#### birthrate
粒子参数的速度乘数因子；每秒发射的粒子数量

#### blueRange
一个粒子的颜色blue能改变的范围

#### blueSpeed
粒子blue在生命周期内的改变速度

#### color
粒子的颜色

#### contents
是个CGImageRef的对象,既粒子要展现的图片

#### contentsRect
应该画在contents里的子rectangle

#### emissionLatitude
发射的z轴方向的角度

#### emissionLongitude
x-y平面的发射方向

#### emissionRange
周围发射角度

#### emitterCells
粒子发射的粒子

#### enabled
粒子是否被渲染

#### greenrange
一个粒子的颜色green 能改变的范围

#### greenSpeed
粒子green在生命周期内的改变速度

#### lifetime
生命周期

#### lifetimeRange
生命周期范围 lifetime= lifetime(+/-) lifetimeRange

#### magnificationFilter
不是很清楚好像增加自己的大小

#### minificatonFilter
减小自己的大小

#### minificationFilterBias
减小大小的因子

#### name
粒子的名字

#### redRange
一个粒子的颜色red能改变的范围

#### redSpeed
粒子red在生命周期内的改变速度

#### scale
缩放比例

#### scaleRange
缩放比例范围

#### scaleSpeed
缩放比例速度

#### spin
子旋转角度

#### spinrange
子旋转角度范围

#### style
不是很清楚

#### velocity
速度

#### velocityRange
速度范围

#### xAcceleration
粒子x方向的加速度分量

#### yAcceleration
粒子y方向的加速度分量

#### zAcceleration
粒子z方向的加速度分量

#### emitterCells
粒子发射的粒子

**注意：**粒子同样有emitterCells属性，也就是说粒子同样可以发射粒子。

## CATransformLayer

系统并没有像之前讲过的几个子类一样，给它一些特殊的属性或者方法：

	@interface CATransformLayer : CALayer
	@end

我们从中可以看出它作为父Layer时，对他的sublayers会有3D效果，也就是说不平面化它的子图层，大家一提到3D效果，就会想到一个神奇的东西景深（景深效果是指当焦点对准某一点时，其前后都仍可清晰的范围。它能决定是把背景模糊化来突出拍摄对象，还是拍出清晰的背景），提到景深，那我们就一定要说CATransform3D，它定义了一个4x4的CGFloat值的矩阵，就是这样的：

```
struct CATransform3D
{
  CGFloat m11, m12, m13, m14;
  CGFloat m21, m22, m23, m24;
  CGFloat m31, m32, m33, m34;
  CGFloat m41, m42, m43, m44;
};

typedef struct CATransform3D CATransform3D;
```
其中的m34，就是上面提到的景深效果的源头。

## CAReplicatorLayer

我们看一下系统提供的API：

#### instanceCount
复制图层的个数，包括复制的这个

#### preservesDepth
子图层是否平面化（看上面那个CATransformLayer）

#### instanceDelay
复制层动画延迟时间

#### instanceTransform
子图层的transform变换，一般用来决定复制图层的初始位置以及初始试图变换

#### instanceColor
复制层颜色，该颜色是与本体元素色值相乘

#### instanceRedOffset
复制层红色偏移量

#### instanceGreenOffset
复制层绿色偏移量

#### instanceBlueOffset
复制层蓝色偏移量

####instanceAlphaOffset
复制层透明度偏移量

## CAScrollLayer
一看到这个你一定想到了UIScrollView，其实它们并没有什么卵关系。首先，他没有提供有关边界的相关思路，另外，也不能响应交互。只有一下滚到这，滚到那的方法。

同样我们可以看到在这个文件下，还有个CALayer的CALayerScrolling分类，不要以为它给CALayer添加了可滑动的方法，其实只是查找第一个可用的CAScrollLayer，并将指定点或者指定区域滚动到可视范围。

不过为了看一下它的效果，使它响应事件，我们可以用UIView的子类来自己写一个简单的ScrollView。

## CATiledLayer
一个大神必备的Layer子类，为节省内存渲染开销提供了途径。比如我们要去加载一个世界地图，精确到你家的那种，如果全部一次性加载到内存中，这无疑是吃不消的，所以我们可以把地图一片片切开，然后按部分加载，大家联想一下地图应用，应该就知道大致是什么效果。

## CATextLayer
我们还是从系统提供的API入手：

#### string
显示内容

#### font
字体

#### fontSize
字号

#### foregroundColor
文字颜色

#### wrapped
是否自适应layer的bounds的大小

#### truncationMode
文字省略方式，其实就是显示不下时省略号的位置

```
kCATruncationNone
kCATruncationStart
kCATruncationEnd
kCATruncationMiddle
```

#### alignmentMode
对齐方式

```
kCAAlignmentNatural
kCAAlignmentLeft
kCAAlignmentRight
kCAAlignmentCenter
kCAAlignmentJustified
```

## CAEAGLLayer
没有OpenGL知识基础，CAEAGLLayer很难理解更不用说使用了。

## AVPlayerLayer
AVPlayerLayer它属于AVFoundation框架，它就是用来播放视频的，`+  (AVPlayerLayer *)playerLayerWithPlayer:(nullable AVPlayer *)player;`它的初始化依赖于AVPlayer，当然，它既然是CALayer的子类，我们就可以对它进行酷炫的效果变换，同样也克服了系统提供的播放器由于高度的封装性， 使得自定义播放器变的很难的问题。