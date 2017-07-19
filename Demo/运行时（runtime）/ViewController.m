//
//  ViewController.m
//  运行时（runtime）
//
//  Created by 刘丰 on 2017/7/11.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Class newClass = objc_allocateClassPair([UIView class], "LFView", 0);
    class_addMethod(newClass, @selector(report), (IMP)reportF, "v@:");
    objc_registerClassPair(newClass);
    
    id instance = [[newClass alloc] init];
    [instance report];
    
//    class_replaceMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>, <#IMP imp#>, <#const char *types#>)
//    method_exchangeImplementations(<#Method m1#>, <#Method m2#>)
//    method_setImplementation(<#Method m#>, <#IMP imp#>)
    
    NSString *str = @"<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" bordercolor=\"#E8E8E8\">";
    NSLog(@"%@", str);
    
    
}

void reportF(id self, SEL _cmd)
{
    NSLog(@"this object is %p", self);
    NSLog(@"class:%@, superClass:%@", [self class], [self superclass]);
}

- (void)report
{
    NSLog(@"%s", __func__);
}

- (void)test
{
    BOOL is = objc_msgSend(self, @selector(runtime));
    NSLog(@"%d", is);
    @synchronized (self) {
        char *buf1 = @encode(int **);
        NSLog(@"%s", buf1);
    }
}

- (BOOL)runtime
{
    SEL sel = @selector(runtime);
    NSLog(@"%@---%d", self, _cmd == sel);
    return false;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return [super resolveInstanceMethod:sel];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"anInvocation:%@", anInvocation);
    
    if ([self respondsToSelector:
         @selector(runtime)]) {
        [anInvocation invokeWithTarget:self];
    }else {
        [super forwardInvocation:anInvocation];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
