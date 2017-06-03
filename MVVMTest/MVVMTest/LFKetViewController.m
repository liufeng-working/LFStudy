//
//  LFKetViewController.m
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/3.
//  Copyright © 2017年 liufeng. All rights reserved.
//

//const修饰后变成 只读变量
/**
 const 修饰基本类型
 
 int const a = 10;
 
 const int b = 10;
 */

/**
 const 修饰指针变量
 
 int *const p = &c;
 *p = 30;
 
 const int *pp = &c;
 int const *pp = &c;
 pp = &d;
 
 const int *const ppp = &c;
 */

/**
 const 修饰对象
 
 NSString *const str = @"123";
 NSString *str1 = @"111";
 
 str = @"321";
 */

//const 使用场景
/**
 1.定义一个只读变量
 2.在方法里定义只读参数
 */
//    NSLog(@"%@", userName);

//static extern

/**
 static用法，
 1.修饰局部变量
 会延长局部变量的生命周期，只要程序运行，局部变量就会一直存在
 局部变量只会分配一次内存
 
 2.修饰全局变量
 只会修改全局变量的作用域，表示只能当前文件内使用
 */

/**
 extern用法，只能用来声明一个全局变量，不能定义
 */

#import "LFKetViewController.h"

/**
 宏：预编译，不会检查错误
 宏的命名规范
 1.
 */

#define test

/**
 const：运行时编译，会自动检查错误
 const:常量
 1.当有字符串常量时，苹果推荐使用const
 */
NSString *const account = @"account";
NSString *const userName = @"userName";

extern int i;

static NSString *const identifier = @"identifier";

@interface LFKetViewController ()

@end

@implementation LFKetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%d", i);
    
    //self superClass class super
    
    NSLog(@"%@-%@-%@", [self class], [self superclass], [super class]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static int i = 0;
    NSLog(@"%d", i);
    i++;
}

- (void)add:(NSString *const)name {
    
//    name = @"123";
    
}

@end
