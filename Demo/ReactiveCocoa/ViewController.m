//
//  ViewController.m
//  ReactiveCocoa
//
//  Created by 刘丰 on 2017/8/3.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>
#import "LFRedView.h"
#import <NSObject+RACKVOWrapper.h>
#import <RACReturnSignal.h>

@interface ViewController ()

@property(nonatomic,strong) id<RACSubscriber> subscriber;

@property (weak, nonatomic) IBOutlet LFRedView *redView;

@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UITextField *textField1;

@property (weak, nonatomic) IBOutlet UIButton *login;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    RACSignal：有数据产生的时候，就会使用
    
    [self skip];
    
}

- (void)skip
{
    //    信号A
    RACSubject *sub = [RACSubject subject];
    [[sub skip:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [sub sendNext:@0];
    [sub sendNext:@0];
    [sub sendNext:@1];
    [sub sendNext:@1];
    [sub sendNext:@2];
    [sub sendNext:@2];
}

- (void)take
{
    //    信号A
    RACSubject *sub = [RACSubject subject];
    [[sub take:1] subscribeNext:^(id  _Nullable x) {
        
    }];
    
    [[sub takeLast:1] subscribeNext:^(id  _Nullable x) {
        
    }];
    
    //表示直到传入的信号发送完成后，就不在接受值
    RACSubject *subb = [RACSubject subject];
    [[sub takeUntil:subb] subscribeNext:^(id  _Nullable x) {
        
    }];
    
    [[sub takeUntilBlock:^BOOL(id  _Nullable x) {
        
        return YES;
    }] subscribeNext:^(id  _Nullable x) {
        
    }];
    
    [[sub takeWhileBlock:^BOOL(id  _Nullable x) {
//        NSLog(@"take:%@", x);
        return NO;
    }] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
    }];
    
    [[sub distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [sub sendNext:@0];
    [sub sendNext:@0];
    [sub sendNext:@1];
    [sub sendNext:@1];
    [subb sendNext:nil];
    [sub sendNext:@2];
    [sub sendNext:@2];
    [sub sendCompleted];
}

//忽略
- (void)ignore
{
    //    信号A
    RACSubject *sub = [RACSubject subject];
    [[sub ignore:@1] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [sub sendNext:@0];
    [sub sendNext:@1];
    [sub sendNext:@2];
}

//过滤
- (void)filter
{
//    信号A
    [[self.textField.rac_textSignal filter:^BOOL(id  _Nullable value) {
        return [value length] > 3;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

//先组合，再聚合
- (void)combine_reduce
{
    //    信号A
    RACSignal *A = self.textField.rac_textSignal;
    
    //    信号B
    RACSignal *B = self.textField1.rac_textSignal;
    
    //组合
    [[RACSignal combineLatest:@[A, B] reduce:^id (NSString *tf1, NSString *tf2){
        return @(tf1.length && tf2.length);
    }] subscribeNext:^(id  _Nullable x) {
        self.login.enabled = [x boolValue];
    }];
}

//两个信号都发送数据，组合信号会一起响应
- (void)combineLatest
{
    //    信号A
    RACSignal *A = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"A");
        [subscriber sendNext:@"AAAAA"];
        return nil;
    }];
    
    //    信号B
    RACSignal *B = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"B");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"BBBBB"];
        });
        return nil;
    }];
    
    //组合
    [[A combineLatestWith:B] subscribeNext:^(id  _Nullable x) {
        RACTupleUnpack(NSString *A, NSString *B) = x;
        NSLog(@"%@-%@", A, B);
    }];
}

//两个信号都发送数据，组合信号会一起响应
- (void)zip
{
    //    信号A
    RACSignal *A = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"A");
        [subscriber sendNext:@"AAAAA"];
        return nil;
    }];
    
    //    信号B
    RACSignal *B = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"B");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"BBBBB"];
        });
        return nil;
    }];
    
    //组合
    [[A zipWith:B] subscribeNext:^(id  _Nullable x) {
        RACTupleUnpack(NSString *A, NSString *B) = x;
        NSLog(@"%@-%@", A, B);
    }];
}

//任意一个信号，发送数据，组合信号都会响应
- (void)merge
{
    //    信号A
    RACSignal *A = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"A");
        [subscriber sendNext:@"AAAAA"];
        return nil;
    }];
    
    //    信号B
    RACSignal *B = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"B");
        [subscriber sendNext:@"BBBBB"];
        return nil;
    }];
    
    //组合
    [[A merge:B] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

//第一个信号发送数据，第二个才会发送，但是组合信号只会响应第二个信号发送的数据
- (void)then
{
    //    信号A
    RACSignal *A = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"A");
        [subscriber sendNext:@"AAAAA"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    //    信号B
    RACSignal *B = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"B");
        [subscriber sendNext:@"BBBBB"];
        return nil;
    }];
    
    //组合
    [[A then:^RACSignal * _Nonnull{
        return B;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

//第一个信号发送数据完毕，才会发送第二个信号的数据，两个都会响应
- (void)concat
{
//    信号A
    RACSignal *A = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"A");
        [subscriber sendNext:@"AAAAA"];
        [subscriber sendCompleted];
        return nil;
    }];
    
//    信号B
    RACSignal *B = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"B");
        [subscriber sendNext:@"BBBBB"];
        return nil;
    }];
    
    //组合
    [[A concat:B] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)map
{
    RACSubject *sub = [RACSubject subject];
    
    RACSignal *singal = [sub map:^id _Nullable(id  _Nullable value) {
        return @"liufeng";
    }];
    
    [singal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [sub sendNext:@123];
}

- (void)flattenMap
{
    //一般用于信号中的信号
    RACSubject *sub = [RACSubject subject];
    
    RACSignal *singal = [sub flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        return [RACReturnSignal return:value];
    }];
    
    [singal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [sub sendNext:@123];
}

- (void)bind
{
    RACSubject *subject = [RACSubject subject];
    RACSignal *bind = [subject bind:^RACSignalBindBlock _Nonnull{
        NSLog(@"1");
        return ^RACSignal * _Nullable (NSNumber * _Nullable value, BOOL *stop) {
            NSLog(@"2");
            return [RACReturnSignal return:@(value.floatValue + 419)];
        };
    }];
    
    [bind subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [subject sendNext:@504];
}

//处理事件
- (void)raccommand
{
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"input:%@", input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"执行命令产生的信号"];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"disposable");
            }];
        }];
    }];
    
    [command.executionSignals subscribeNext:^(id  _Nullable x) {
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@", x);
        }];
    }];
    
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [command execute:@1];
    
}

- (void)raccommand1
{
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"input:%@", input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"执行命令产生的信号"];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"disposable");
            }];
        }];
    }];
    
    RACSignal *signal = [command execute:@1];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)racmulticastconnection
{
    //解决每次订阅都请求的问题
    //RACMulticastConnection:必须要有信号，才能使用
    
//    1.创建信号
    RACSignal *hotSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //请求数据
        NSLog(@"请求热销模块数据");
        [subscriber sendNext:@"热销模块的数据"];
        return nil;
    }];
    
//    2.把信号转化成连接类
    RACMulticastConnection *connection = [hotSignal publish];
    
//    3.订阅连接类信号
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者一%@", x);
    }];
    
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者二%@", x);
    }];
    
//    4.连接
    [connection connect];
}

- (void)macro
{
    RAC(self.button.titleLabel, text) = self.textField.rac_textSignal;
    
    RACTuplePack(@1, @2);
}

- (void)replace
{
//    1.代替代理
    [[self.redView rac_signalForSelector:NSSelectorFromString(@"redClick:")] subscribeNext:^(RACTuple * _Nullable x) {
//        NSLog(@"%@", x);
        self.redView.frame = CGRectMake(100, 100, 300, 300);
    }];
    
//    2.代替KVO
    [[self.redView rac_valuesAndChangesForKeyPath:@"frame" options:NSKeyValueObservingOptionNew observer:self] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [self.redView rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionNew observer:self block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        NSLog(@"%@", value);
    }];
    
//    3.监听事件
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"按钮点击了");
    }];
    
//    4.代替通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"%@", x);
    }];
    
//    5.监听文本改变
    [self.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@", x);
    }];
    
//    6.多个请求都返回数据时，再操作
    
    //请求热销模块
    RACSignal *hotSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //请求数据
        NSLog(@"请求热销模块数据");
        [subscriber sendNext:@"热销模块的数据"];
        return nil;
    }];
    
    //请求最新模块
    RACSignal *newSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //请求数据
        NSLog(@"请求最新模块数据");
        [subscriber sendNext:@"最新模块的数据"];
        return nil;
    }];
    
    [self rac_liftSelector:@selector(liftWithHot:new:) withSignalsFromArray:@[hotSignal, newSignal]];
}

- (void)liftWithHot:(NSString *)hot new:(NSString *)new
{
    NSLog(@"%@---%@", hot, new);
}

- (void)racsequence
{
    
    NSDictionary *dic = @{@"liufeng": @"boy", @"chenbei": @"girl"};
    [dic.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        RACTupleUnpack(NSString *key, NSString *value) = x;
        NSLog(@"%@---%@", key, value);
    }];
    
    
    NSArray *arr = @[@"123", @"234", @"345"];
    RACSequence *sequence = [arr rac_sequence];
    [sequence.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
    }];
}

- (void)ractuple
{
    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"123", @"234", @"345"]];
    NSLog(@"%@", tuple[0]);
}

- (void)delegate
{
    [self.redView.btnClickSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)replaysubject
{
    RACReplaySubject *replay = [RACReplaySubject subject];
    [replay sendNext:@1];
    [replay subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
}

- (void)racsubject
{
    //被订阅，仅仅是保存订阅者
    RACSubject<NSNumber *> *subject = [RACSubject subject];
    [subject subscribeNext:^(NSNumber * _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    //遍历所有的订阅者，发送数据
    [subject sendNext:@1];
}

- (void)racsignal
{
    //    1.创建信号，冷信号
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        self_weak_.subscriber = subscriber;
        //    3.发送数据
        [subscriber sendNext:@1];
        
        //默认信号发送完毕，就会取消订阅
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"%@", @"disposable");
        }];
    }];
    
    //    2.订阅信号，热信号
    RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"222-%@", x);
    }];
    
    [disposable dispose];
}

@end
