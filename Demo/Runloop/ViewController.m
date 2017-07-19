//
//  ViewController.m
//  Runloop
//
//  Created by 刘丰 on 2017/7/17.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong) dispatch_source_t time;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //每个线程都有唯一一个runloop与之对应
    //runloop中有多种运行模式，runloop只能运行在某一种运行模式，运行模式中必须有一个源或者定时器
    
//    NSLog(@"%@", [NSRunLoop currentRunLoop]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self timer];
//    [NSThread detachNewThreadWithBlock:^{
//        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(run) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] run];
//    }];
//    [self gcdTimer];
    [self runloopObserver];
}

- (void)runloopObserver
{
    //1 runloop
    //2 监听者
    //3 模式
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    
    //1 怎么分配存储空间，默认
    //2 监听的runloop状态
    //3 是否持续监听
    //4 优先级，总是传0
    //5 runloop状态改变时，会回调
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        /*
         kCFRunLoopEntry = (1UL << 0), 即将进入runloop
         kCFRunLoopBeforeTimers = (1UL << 1), 即将处理timer事件
         kCFRunLoopBeforeSources = (1UL << 2), 即将处理source事件
         kCFRunLoopBeforeWaiting = (1UL << 5), 即将进入睡眠
         kCFRunLoopAfterWaiting = (1UL << 6), 唤醒
         kCFRunLoopExit = (1UL << 7), 退出
         kCFRunLoopAllActivities = 0x0FFFFFFFU
         */
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"即将进入runloop");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"即将处理timer事件");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"即将处理source事件");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"即将进入睡眠");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"唤醒");
                break;
            case kCFRunLoopExit:
                NSLog(@"退出");
                break;
            default:
                break;
        }
    });
    CFRunLoopAddObserver(runloop, observer, kCFRunLoopDefaultMode);
}

- (void)gcdTimer
{
    //1.创建定时器
    //1 source类型
    //2 描述信息，线程ID
    //3 详细的描述信息
    //4 队列，决定GCD定时器中的任务在哪个线程中执行
    self.time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    
    //2.设置定时器（起始时间，间隔时间，精准度）
    //1 定时器对象
    //2 起始时间
    //3 时间间隔
    //4 精准度 绝对精准0
    dispatch_source_set_timer(self.time, DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    //3.设置定时器执行的任务
    dispatch_source_set_event_handler(self.time, ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
    
    //4. 启动执行
    dispatch_resume(self.time);
    
}

- (void)timer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    //NSRunLoopCommonModes = UITrackingRunLoopMode + NSDefaultRunLoopMode
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)runloop
{
    NSLog(@"%p", [NSRunLoop mainRunLoop].getCFRunLoop);
    
    NSLog(@"%p", CFRunLoopGetMain());
    
    [[[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil] start];
}

- (void)run
{
    NSLog(@"%@", [NSThread currentThread]);
    NSLog(@"%@", [NSRunLoop currentRunLoop].currentMode);
}


@end
