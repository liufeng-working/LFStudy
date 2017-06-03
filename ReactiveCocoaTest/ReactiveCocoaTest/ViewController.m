//
//  ViewController.m
//  ReactiveCocoaTest
//
//  Created by 刘丰 on 2017/5/30.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveObjC.h"
#import "RACReturnSignal.h"
#import "NSObject+RACKVOWrapper.h"
#import "LFRedView.h"
#import "LFFlag.h"

@interface ViewController ()

@property(nonatomic,strong) id<RACSubscriber> subscriber;

@property (weak, nonatomic) IBOutlet LFRedView *redView;

@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self skip];
}

- (void)skip
{
    //创建信号
    RACSubject *subject = [RACSubject subject];
    
    //跳过几个值
    [[subject skip:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendCompleted];
}

- (void)take
{
    //创建信号
    RACSubject *subject = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    
    [[subject takeUntil:signal] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
//    [subject distinctUntilChanged];
    
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
//    [signal sendCompleted];
    [signal sendNext:@1];
    [subject sendNext:@"3"];
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendCompleted];
}

- (void)ignore
{
    //创建信号
    RACSubject *subject = [RACSubject subject];
    
    [[subject ignore:@"1"] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
}

- (void)filter
{
    //创建信号
    //只有当文本框的内容大于，才获取内容
    [[self.textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length > 5;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)zip
{
    //创建信号
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"%@", @"顶部请求");
        [subscriber sendNext:@"1"];
        
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"%@", @"底部请求");
        [subscriber sendNext:@"2"];
        
        return nil;
    }];
    
    [[signalB zipWith:signalA] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)merge
{
    //创建信号
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"%@", @"顶部请求");
        [subscriber sendNext:@"发送上部分的数据"];
        
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"%@", @"底部请求");
        [subscriber sendNext:@"发送下部分的数据"];
        
        return nil;
    }];
    
    [[signalB merge:signalA] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)then
{
    //创建信号
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"%@", @"顶部请求");
        [subscriber sendNext:@"发送上部分的数据"];
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"%@", @"底部请求");
        [subscriber sendNext:@"发送下部分的数据"];
        
        return nil;
    }];
    
    [[signalA then:^RACSignal * _Nonnull{
        return signalB;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)concat
{
    //创建信号
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"%@", @"发送一个顶部请求");
        [subscriber sendNext:@"发送上部分的数据"];
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"%@", @"发送一个底部请求");
        [subscriber sendNext:@"发送下部分的数据"];
        
        return nil;
    }];
    
    [[signalA concat:signalB] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)map
{
    //创建信号
    RACSubject *subject = [RACSubject subject];
    
    //绑定信号
    RACSignal *bindSignal = [subject map:^id _Nullable(id  _Nullable value) {
        return @"111";
    }];
    
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [subject sendNext:@"123"];
}

- (void)flattenMap
{
    //创建信号
    RACSubject *signalOfSignal = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    
    //绑定信号
    [[signalOfSignal flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        return value;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    //发送数据
    [signalOfSignal sendNext:signal];
    [signal sendNext:@"123"];
}

- (void)bind
{
    //1.创建信号
    RACSubject *subject = [RACSubject subject];
    
    //2.绑定信号
    RACSignal *bindSignal = [subject bind:^RACSignalBindBlock _Nonnull{
        
        return ^RACSignal * _Nullable(id _Nullable value, BOOL *stop) {
            //block调用：只要源信号发送数据，就会调用block
            
            NSLog(@"block-%@", value);
            
            value = [NSString stringWithFormat:@"liufeng%@", value];
            return [RACReturnSignal return:value];
        };
    }];
    
    //3.订阅绑定信号
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    //4.发送数据
    [subject sendNext:@1];
}

- (void)command1
{
    //处理按钮点击，网络请求
    //只要执行命令block就会执行
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id _Nullable input) {
        
        //input:执行命令传人的参数
        NSLog(@"%@", input);
        
        //返回的信号不能为空
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"执行命令产生的数据"];
            //发送数据完成，需要手动主动执行完成
            [subscriber sendCompleted];
            return nil;
        }];;
    }];
    
    //监听事件有么有完成
    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
        if (x.boolValue) {//当前正在执行
            NSLog(@"当前正在执行");
        }else {//执行完成／没有执行
            NSLog(@"执行完成／没有执行");
        }
    }];
    
    //执行命令
    [[command execute:@1234] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)command
{
    //处理按钮点击，网络请求
    //只要执行命令block就会执行
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"%@", input);
        
        //返回的信号不能为空
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"执行命令产生的数据"];
            return nil;
        }];;
    }];
    
    //订阅命令内部的信号
    //方式1,要在执行命令前去订阅
    //executionSignals信号源：信号中的信号，signalOfSignals:发送的数据就是信号
    [command.executionSignals subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"1-%@", x);
        }];
    }];
    
    //方式2,要在执行命令前去订阅
    //switchToLatest获取信号中的信号发送的最新的信号，只能用在信号中的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"2-%@", x);
    }];

    //执行命令
    RACSignal *signal = [command execute:@1234];
    
    
    //方式3，可以在执行命令后去订阅
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"3-%@", x);
    }];
    
}

- (void)multicastConnection
{
    //RACMulticastConnection:解决多次订阅时，只发送一次数据
    //必须要有信号，才能创建RACMulticastConnection
    //1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"发送热门模块的请求");
        //3.发送信号
        [subscriber sendNext:@1];
        
        return nil;
    }];
    
    //2.把信号转换成链接类
    RACMulticastConnection *connection = [signal publish];
    
    //3.订阅链接类的信号
    [connection.signal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"1-%@", x);
    }];
    
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"2-%@", x);
    }];
    
    //4.链接
    [connection connect];
}

- (void)test5
{
    
    
    [self.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        [self.btn setTitle:x forState:UIControlStateNormal];
    }];
    
    //用来给某个对象的某个属性绑定信号，只要产生信号内容，就会把内容给属性赋值
    //    RAC(self.btn, titleLabel.text) = self.textField.rac_textSignal;
    RAC(self.btn, titleLabel.text, @"占位字符") = RACObserve(self.textField, text);
}

- (void)lift
{
    //6.多个请求全部完成时，才去刷新页面
    //热销模块
    RACSignal *hotSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"请求热销模块数据");
        [subscriber sendNext:@"热销模块数据"];
        return nil;
    }];
    
    //最新模块
    RACSignal *newSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [NSThread sleepForTimeInterval:5];
        NSLog(@"请求最新模块数据");
        [subscriber sendNext:@"最新模块数据"];
        
        return nil;
    }];
    [self rac_liftSelector:@selector(updateUIWithHotData:newData:) withSignalsFromArray:@[hotSignal, newSignal]];
}

- (void)updateUIWithHotData:(id)hotData newData:(id)newData
{
    NSLog(@"%@-%@", hotData, newData);
}

- (void)sequence
{
    NSArray *arr = @[@"123", @"321", @1];
    //集合类
    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:arr];
    NSString *str = tuple.fifth;
    NSLog(@"%@", str);
    
    RACSequence *sequence = arr.rac_sequence;
    [sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [arr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    NSDictionary *dic = @{@"userName": @"liufeng", @"age": @"25"};
    [dic.rac_sequence.signal subscribeNext:^(RACTwoTuple *x) {
        //        NSString *key = x[0];
        //        NSString *value = x[1];
        
        RACTupleUnpack(NSString *key, NSString *value) = x;
        NSLog(@"%@-%@", key, value);
    }];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"flag.plist" ofType:nil];
    NSArray *dicArr = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *tem = [NSMutableArray array];
    [dicArr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        [tem addObject:[LFFlag flagWithDic:x]];
    }];
    
    [[dicArr.rac_sequence map:^id _Nullable(id  _Nullable value) {
        return [LFFlag flagWithDic:value];
    }].signal subscribeNext:^(LFFlag *x) {
        NSLog(@"%@", x.name);
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.redView.frame = CGRectMake(100, 100, 100, 100);
}

- (void)event_notification_textChange
{
    //3.监听事件
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"%@", @"按钮点击了");
    }];
    
    //4.通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    //5.监听文本框文字改变
    [[self.textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)KVO
{
    //2.KVO
    [[self.redView rac_valuesForKeyPath:@"frame" observer:self] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [[self.redView rac_valuesAndChangesForKeyPath:@"frame" options:NSKeyValueObservingOptionNew observer:self] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [self.redView rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionNew observer:self block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        NSLog(@"%@", change);
    }];
}

- (void)delegate
{
    //1.代理  RACSubject
    [[self rac_signalForSelector:@selector(didReceiveMemoryWarning)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"didReceiveMemoryWarning");
    }];
    
//    [[self.redView rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(RACTuple * _Nullable x) {
//        NSLog(@"%@", @"rac按钮被电击了");
//    }];
    
    
    [self.redView.btnClickSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)test4
{
    
    //1.创建信号(可以先发送数据后订阅信号)
    RACReplaySubject *subject = [RACReplaySubject subject];
    
    //3.发送数据
    [subject sendNext:@"111"];
    [subject sendNext:@"222"];
    //2.订阅信号
    [subject subscribeNext:^(id  _Nullable x) {
       NSLog(@"%@", x);
    }];
    
}

- (void)test3
{
    [super viewDidLoad];
    
    //1.创建信号
    RACSubject *subject = [RACSubject subject];
    
    //2.订阅信号
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"1-%@", x);
    }];
    
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"2-%@", x);
    }];
    
    //3.发送数据
    [subject sendNext:@"123"];
    [subject sendNext:@"234"];
}

- (void)test2
{
    [super viewDidLoad];
    
    //1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        _subscriber = subscriber;
        
        //3.发送数据
        [subscriber sendNext:@"123"];
        
        return [RACDisposable disposableWithBlock:^{
            //只要信号取消，就会来这里
            //做一些事情，比如清空资源
            //默认一个信号发送完成后就会被取消，但是只要订阅者还存在，信号就不会被自动取消
            NSLog(@"订阅的信号被取消了");
        }];
    }];
    
    //2.订阅信号
    RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
        //创建订阅者，保存nextBlock
        //订阅信号
        
        NSLog(@"%@", x);
    }];
    
    //手动取消订阅
    [disposable dispose];
    
}

- (void)test1
{
    
    //RACSignal:有信号产生的时候使用
    //使用步骤
    //1.创建信号（冷信号）
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //subscriber调用：只要一个信号被订阅就会调用
        //subscriber作用：只发信号
        NSLog(@"信号被订阅");
        //3.发送信号
        [subscriber sendNext:@1];
        
        return nil;
    }];
    
    //2.订阅信号（热信号）
    [signal subscribeNext:^(id  _Nullable x) {
        
        //subscribeNext调用：只要订阅者发送数据就会调用
        //subscribeNext作用：处理数据，展示到UI上面
        //x:信号发送的内容
        NSLog(@"%@", x);
    }];
    
    //只要订阅者调用sendNext，就会执行nextBlock
    //只要信号被订阅，就会执行didSubscribute
    //前提条件是RACDynamicSignal，不同类型的订阅，处理时间的方法不一样
}

@end
