//
//  ViewController.m
//  图层
//
//  Created by 刘丰 on 2017/7/28.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CALayerDelegate> {
    CGPoint startPoint;
    CATransformLayer *s_Cube;
    float pix;
    float piy;
}

@property(nonatomic,strong) dispatch_source_t timer;

@property(nonatomic,weak) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
 
//    [self startStroke];
//    [self checkFillRule];
    
    [self textLayer];
}

- (void)textLayer
{
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.bounds = CGRectMake(0, 0, 200, 200);
    textLayer.position = self.view.center;
    [self.view.layer addSublayer:textLayer];
    
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentLeft;
    textLayer.wrapped = YES;
    //以Retina方式来渲染，防止画出来的文本模糊
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    textLayer.truncationMode = kCATruncationEnd;
    
    UIFont *font = [UIFont systemFontOfSize:15];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    NSString *text = @"Age has reached the end of the beginning of a word. May be guilty in his seems to passing a lot of different life became the appearance of the same day; May be back in the past, to oneself the paranoid weird belief disillusionment, these days, my mind has been very messy, in my mind constantly. Always feel oneself should go to do something, or write something. Twenty years of life trajectory deeply shallow, suddenly feel something, do it.";
    
    textLayer.string = text;
}

- (void)tiledLayer
{
    CATiledLayer *tileLayer = [CATiledLayer layer];
    tileLayer.frame = CGRectMake(0, 0, self.view.frame.size.width * 4, self.view.frame.size.height * 4);
    tileLayer.tileSize = self.view.frame.size;
    tileLayer.delegate = self;
    //
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.scrollView.contentSize = tileLayer.frame.size;
    [self.scrollView.layer addSublayer:tileLayer];
    //
    [tileLayer setNeedsDisplay];
}

-(void)drawLayer:(CATiledLayer *)layer inContext:(CGContextRef)ctx{
    CGRect bounds = CGContextGetClipBoundingBox(ctx);
    UIImage *tileImage = [UIImage imageNamed:@"1"];
    //
    UIGraphicsPushContext(ctx);
    [tileImage drawInRect:bounds];
    UIGraphicsPopContext();
}

-(void)followPathLayer{
    UIBezierPath *path = [self followPath];
    //
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = self.view.frame;
    replicatorLayer.position = self.view.center;
    [self.view.layer addSublayer:replicatorLayer];
    //
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = 5;
    layer.bounds = CGRectMake(0, 0, 10, 10);
    layer.position = CGPointMake(20, self.view.center.y);
    [replicatorLayer addSublayer:layer];
    //
    CAKeyframeAnimation *basicAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    basicAni.path = path.CGPath;
    basicAni.duration = 3;
    basicAni.repeatCount = NSIntegerMax;
    [layer addAnimation:basicAni forKey:@"layerPosition"];
    //
    replicatorLayer.instanceCount = 15;
    replicatorLayer.instanceDelay = 0.3;
}

-(UIBezierPath*)followPath{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, self.view.center.y)];
    [path addCurveToPoint:CGPointMake(self.view.bounds.size.width - 20, self.view.center.y) controlPoint1:CGPointMake(130, self.view.center.y - 100) controlPoint2:CGPointMake(240, self.view.center.y + 100)];
    [path closePath];
    shapeLayer.path = path.CGPath;
    shapeLayer.lineWidth = 5;
    shapeLayer.strokeColor = [UIColor grayColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    [self.view.layer addSublayer:shapeLayer];
    return path;
}

-(void)lineRoundRoll{
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = self.view.frame;
    replicatorLayer.position = self.view.center;
    [self.view.layer addSublayer:replicatorLayer];
    //
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = 20;
    layer.bounds = CGRectMake(0, 0, 40, 40);
    layer.position = CGPointMake(50, self.view.center.y);
    layer.transform = CATransform3DMakeScale(0, 0, 0);
    [replicatorLayer addSublayer:layer];
    //
    CABasicAnimation *basicAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAni.fromValue = @(1);
    basicAni.toValue = @(0);
    basicAni.duration = 1.2;
    basicAni.repeatCount = NSIntegerMax;
    [layer addAnimation:basicAni forKey:@"layerPosition"];
    
    replicatorLayer.instanceCount = 15;
    replicatorLayer.preservesDepth = YES;
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, M_PI*2/15.0, 0, 0, 1);
    replicatorLayer.instanceTransform = transform;
    replicatorLayer.instanceDelay = 0.08;
    replicatorLayer.instanceAlphaOffset = -1.0/15.0;
    replicatorLayer.instanceBlueOffset = 1.0/15;
    replicatorLayer.instanceColor = [UIColor redColor].CGColor;
}

-(void)lineWave{
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = self.view.frame;
    replicatorLayer.position = self.view.center;
    [self.view.layer addSublayer:replicatorLayer];
    //
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 10, 40);
    layer.position = CGPointMake(50, self.view.center.y);
    [replicatorLayer addSublayer:layer];
    //
    CABasicAnimation *basicAni = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    basicAni.toValue = @(0.1);
    basicAni.duration = 0.4;
    basicAni.autoreverses = YES;
    basicAni.repeatCount = NSIntegerMax;
    [layer addAnimation:basicAni forKey:@"layerPosition"];
    
    replicatorLayer.instanceCount = 8;
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 40, 0, 0);
    replicatorLayer.instanceTransform = transform;
    replicatorLayer.instanceDelay = 0.1;
}

- (void)cube
{
    CATransform3D c1t = CATransform3DIdentity;
    CALayer *cube1 = [self cubeWithTransform:c1t];
    s_Cube = (CATransformLayer *)cube1;
    [self.view.layer addSublayer:cube1];
}
- (CALayer *)faceWithTransform:(CATransform3D)transform color:(UIColor*)color
{
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(-50, -50, 100, 100);
    face.backgroundColor = color.CGColor;
    face.transform = transform;
    return face;
}

- (CALayer *)cubeWithTransform:(CATransform3D)transform
{
    //容器
    CATransformLayer *cube = [CATransformLayer layer];
    
    //前
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 60);
    [cube addSublayer:[self faceWithTransform:ct color:[UIColor redColor]]];
    
    //右
    ct = CATransform3DMakeTranslation(60, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct color:[UIColor yellowColor]]];
    
    //上
    ct = CATransform3DMakeTranslation(0, -60, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct color:[UIColor blueColor]]];
    
    //下
    ct = CATransform3DMakeTranslation(0, 60, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct color:[UIColor brownColor]]];
    
    //左
    ct = CATransform3DMakeTranslation(-60, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct color:[UIColor greenColor]]];
    
    //后
    ct = CATransform3DMakeTranslation(0, 0, -60);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct color:[UIColor orangeColor]]];
    
    //
    CGSize containerSize = self.view.bounds.size;
    cube.position = CGPointMake(containerSize.width / 2.0,
                                containerSize.height / 2.0);
    
    cube.transform = transform;
    return cube;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    startPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self.view];
    CGFloat deltaX = startPoint.x - currentPosition.x;
    CGFloat deltaY = startPoint.y - currentPosition.y;
    CATransform3D c1t = CATransform3DIdentity;
    c1t = CATransform3DRotate(c1t, pix + M_PI_2 * deltaY / 100, 1, 0, 0);
    c1t = CATransform3DRotate(c1t, piy - M_PI_2 * deltaX / 100, 0, 1, 0);
    s_Cube.transform = c1t;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self.view];
    CGFloat deltaX = startPoint.x - currentPosition.x;
    CGFloat deltaY = startPoint.y - currentPosition.y;
    pix = M_PI_2 * deltaY / 100;
    piy = -M_PI_2 * deltaX / 100;
}

- (void)transformLayer1
{
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(50, 50);
    layer.opacity = 0.6;
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.borderWidth = 5;
    layer.borderColor = [[UIColor greenColor] colorWithAlphaComponent:0.4].CGColor;
    layer.cornerRadius = 20;
    layer.masksToBounds = YES;
    
    CALayer *containerLayer = [CATransformLayer layer];
    containerLayer.bounds = CGRectMake(0, 0, 100, 100);
    containerLayer.position = self.view.center;
    containerLayer.position = CGPointMake(50, 50);
    [containerLayer addSublayer:layer];
    [self.view.layer addSublayer:containerLayer];
    
    CATransform3D containerTransform = CATransform3DIdentity;
    //看这，我是新加的
    containerTransform = CATransform3DRotate(containerTransform, M_PI_2, 0, 1, 0);
    containerLayer.transform = containerTransform;
    
    CATransform3D fromValue = CATransform3DIdentity;
    fromValue = CATransform3DRotate(fromValue, M_PI_2, 0, 1, 0);
    layer.transform = fromValue;
}

- (void)transformLayer
{
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.opacity = 0.6;
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.borderWidth = 5;
    layer.borderColor = [[UIColor greenColor] colorWithAlphaComponent:0.4].CGColor;
    layer.cornerRadius = 20;
    layer.masksToBounds = YES;
    
    CALayer *layer_2 = [CALayer layer];
    layer_2.bounds = CGRectMake(0, 0, 100, 100);
    layer_2.opacity = 0.6;
    layer_2.backgroundColor = [UIColor blueColor].CGColor;
    layer_2.borderWidth = 5;
    layer_2.borderColor = [[UIColor orangeColor] colorWithAlphaComponent:0.4].CGColor;
    layer_2.cornerRadius = 20;
    layer_2.masksToBounds = YES;
    //
    CALayer *containerLayer = [CATransformLayer layer];
    containerLayer.bounds = CGRectMake(0, 0, 100, 100);
    containerLayer.position = self.view.center;
    layer.position = CGPointMake(50, 50);
    layer_2.position = CGPointMake(50, 50);
    [containerLayer addSublayer:layer];
    [containerLayer addSublayer:layer_2];
    [self.view.layer addSublayer:containerLayer];
    //
    CATransform3D containerTransform = CATransform3DIdentity;
    containerTransform.m34 = -1.0 / 500.0;
    containerLayer.transform = containerTransform;
    //
    CATransform3D fromValue = CATransform3DIdentity;
    fromValue = CATransform3DRotate(fromValue, M_PI_2, 0, 1, 0);
    fromValue = CATransform3DTranslate(fromValue, 0, 0, -10);
    layer.transform = fromValue;
    
    CATransform3D fromValue_2 = CATransform3DIdentity;
    fromValue_2 = CATransform3DRotate(fromValue_2, M_PI_2, 0, 1, 0);
    fromValue_2 = CATransform3DTranslate(fromValue_2, 0, 0, -50);
    layer_2.transform = fromValue_2;
}

- (void)transform3D
{
    
    CALayer *layer_ = [CALayer layer];
    layer_.bounds = CGRectMake(0, 0, 100, 100);
    layer_.position = CGPointMake(self.view.center.x, 200);
    layer_.opacity = 0.6;
    layer_.backgroundColor = [UIColor redColor].CGColor;
    layer_.borderWidth = 5;
    layer_.borderColor = [[UIColor greenColor] colorWithAlphaComponent:0.4].CGColor;
    layer_.cornerRadius = 20;
    layer_.masksToBounds = YES;
    [self.view.layer addSublayer:layer_];
    //
    CATransform3D fromValue_ = CATransform3DIdentity;
    fromValue_ = CATransform3DRotate(fromValue_, M_PI_2 / 2, 0, 1, 0);
    layer_.transform = fromValue_;
    
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = self.view.center;
    layer.opacity = 0.6;
    layer.backgroundColor = [UIColor blueColor].CGColor;
    layer.borderWidth = 5;
    layer.borderColor = [[UIColor orangeColor] colorWithAlphaComponent:0.4].CGColor;
    layer.cornerRadius = 20;
    layer.masksToBounds = YES;
    [self.view.layer addSublayer:layer];
    //
    CATransform3D fromValue = CATransform3DIdentity;
    fromValue.m34 = 1.0 / -500;
    fromValue = CATransform3DRotate(fromValue, M_PI_2 / 2, 0, 1, 0);
    layer.transform = fromValue;
}

//CAGradientLayer
-(void)creatGradientLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.bounds = CGRectMake(0, 0, 220, 220);
    gradientLayer.position = self.view.center;
    [self.view.layer addSublayer:gradientLayer];
    //
    NSMutableArray *colorArray = [NSMutableArray new];
    for (NSInteger hue = 0; hue <= 360; hue += 5) {
        UIColor *color = [UIColor colorWithHue:1.0*hue/360.0
                                    saturation:1.0
                                    brightness:1.0
                                         alpha:1.0];
        [colorArray addObject:(id)color.CGColor];
    }
    //
    gradientLayer.colors = colorArray;
    //gradientLayer.locations = @[@(0.3),@(0.7)];
    //
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    //ShapeLayer
    UIBezierPath *bezierP = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 200, 200)];
    CAShapeLayer* shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = bezierP.CGPath;
    shapeLayer.lineWidth = 10;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 0;
    gradientLayer.mask = shapeLayer;
    
    //
    NSTimeInterval delayTime = 1.0f;
    NSTimeInterval timeInterval = 0.5f;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_time_t startDelayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC));
    dispatch_source_set_timer(_timer, startDelayTime, timeInterval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (shapeLayer.strokeEnd < 0.6) {
                shapeLayer.strokeEnd += 0.4;
            }else if (shapeLayer.strokeEnd < 0.8){
                shapeLayer.strokeEnd += 0.2;
            }else if (shapeLayer.strokeEnd < 1){
                shapeLayer.strokeEnd += 0.1;
            }else{
                dispatch_source_cancel(_timer);
            }
        });
    });
    dispatch_resume(_timer);
}

- (void)demo
{
    CAShapeLayer* dashLineShapeLayer = [CAShapeLayer layer];
    //创建贝塞尔曲线
    UIBezierPath* dashLinePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 200, 100) cornerRadius:20];
    
    dashLineShapeLayer.path = dashLinePath.CGPath;
    dashLineShapeLayer.position = CGPointMake(100, 100);
    dashLineShapeLayer.fillColor = [UIColor clearColor].CGColor;
    dashLineShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    dashLineShapeLayer.lineWidth = 3;
    dashLineShapeLayer.lineDashPattern = @[@(6),@(6)];
    dashLineShapeLayer.strokeStart = 0;
    dashLineShapeLayer.strokeEnd = 1;
    dashLineShapeLayer.zPosition = 999;
    [self.view.layer addSublayer:dashLineShapeLayer];
    
    //
    NSTimeInterval delayTime = 0.3f;
    //定时器间隔时间
    NSTimeInterval timeInterval = 0.1f;
    //创建子线程队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //使用之前创建的队列来创建计时器
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置延时执行时间，delayTime为要延时的秒数
    dispatch_time_t startDelayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC));
    //设置计时器
    dispatch_source_set_timer(_timer, startDelayTime, timeInterval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        //执行事件
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CGFloat _add = 3;
            dashLineShapeLayer.lineDashPhase -= _add;
        });
    });
    // 启动计时器
    dispatch_resume(_timer);
}

- (void)startStroke
{
    UIBezierPath* bezierPath_rect = [UIBezierPath bezierPathWithRect:CGRectMake(30, 50, 100, 100)];
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath_rect.CGPath;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.lineWidth = 1;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 0.6;
    shapeLayer.lineDashPattern = @[@1, @2, @3];
    shapeLayer.lineDashPhase = 20;
    [self.view.layer addSublayer:shapeLayer];
}

-(void)checkFillRule{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGPoint circleCenter = self.view.center;
    [path moveToPoint:CGPointMake(circleCenter.x + 50, circleCenter.y)];
    [path addArcWithCenter:circleCenter radius:50 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(circleCenter.x + 100, circleCenter.y)];
    [path addArcWithCenter:circleCenter radius:100 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(circleCenter.x + 150, circleCenter.y)];
    [path addArcWithCenter:circleCenter radius:150 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor greenColor].CGColor;
    shapeLayer.fillRule = kCAFillRuleNonZero;
//    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinBevel;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    
    //add it to our view
    [self.view.layer addSublayer:shapeLayer];
}

@end
