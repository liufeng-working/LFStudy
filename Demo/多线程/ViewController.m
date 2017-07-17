//
//  ViewController.m
//  多线程
//
//  Created by 刘丰 on 2017/7/16.
//  Copyright © 2017年 liufeng. All rights reserved.
//

//线程的状态
/*
 1. 新建
 2. 就绪
 3. 运行
 4. 阻塞
 5. 死亡
 */

#import "ViewController.h"
#import <pthread.h>
#import "LFThread.h"

@interface ViewController ()

@property(nonatomic,strong) NSThread *a;

@property(nonatomic,strong) NSThread *b;

@property(nonatomic,strong) NSThread *c;

@property(nonatomic,assign) NSInteger sum;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self ticket];
}

#pragma mark -
#pragma mark - 线程安全，加锁
- (void)ticket
{
    self.sum = 100;
    
    self.a = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.a.name = @"A";
    self.a.threadPriority = 1;
    [self.a start];
    
    self.b = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.b.name = @"B";
    self.b.threadPriority = 0.1;
    [self.b start];
    
    self.c = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.c.name = @"C";
    [self.c start];
}

- (void)saleTicket
{
    while (YES) {
        
        //锁：必须时全局唯一的
        /*
         1. 加锁的位置
         2. 加锁的条件，多个线程访问同一个资源
         3. 加锁是需要耗费性能的
         4. 加锁后造成线程同步
         */
        @synchronized (self) {
            if (self.sum > 0) {
//                sleep(0.1);
                self.sum -= 1;
                NSLog(@"%@卖出去一张票,剩余%ld", [NSThread currentThread].name, (long)self.sum);
            }else {
                NSLog(@"票卖完了");
                break;
            }
        }
    }
}

#pragma mark -
#pragma mark - pthread
- (void)pthread
{
    //创建线程对象
    pthread_t pthread;
    
    //创建线程
    /*参数
     1.线程对象，传递地址
     2.线程属性NULL
     3.函数指针
     4.
     */
    pthread_create(&pthread, NULL, task, NULL);
}

void *task(void *param) {
    NSLog(@"%@", [NSThread currentThread]);
    return NULL;
}

#pragma mark -
#pragma mark - NSThread
- (void)nsthread
{
    //生命周期，当线程中的任务执行完毕后，在当前线程释放
    LFThread *thread = [[LFThread alloc] initWithTarget:self selector:@selector(task) object:nil];
    [thread start];
}

- (void)task
{
    NSLog(@"%@", [NSThread currentThread]);
}

@end
