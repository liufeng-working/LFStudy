//
//  LFTestViewController.m
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/2.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFTestViewController.h"
#import "LFiOS.h"
#import "LFJava.h"
#import "LFPerson.h"
#import "LFSon.h"

@interface LFTestViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property(nonatomic,copy,nullable) NSString *name;
//@property(nonatomic,copy) NSString *_Nullable name;
//@property(nonatomic,copy) NSString *__nullable name;

@property(nonatomic,copy,nonnull) NSString *icon;
//@property(nonatomic,copy) NSString *_Nonnull icon;
//@property(nonatomic,copy) NSString *__nonnull icon;

/**
 null_resettable
 */
@property(nonatomic,copy,null_resettable) NSString *ID;

/**
 null_unspecified
 */
@property(nonatomic,copy,null_unspecified) NSString *liufeng;

@property(nonatomic,strong,nullable) NSMutableArray<NSString *> *datas;

@end

@implementation LFTestViewController

/**
 泛型：限制类型
 
 使用场景
 1.集合（NSArray, NSDictionary, NSSet）中使用
 2.当声明一个类，类里面的属性不确定，这时候使用泛型
 
 好处
 1.提高开发规范，减少程序员之间的交流
 2.取出的类型直接就是泛型规定的类型
 3.可以直接使用点语法
 
 书写规范
 1.在类型后面定义泛型，NSMutableArray<NSString *> *datas
 2.只能修饰方法的调用
 */

- (NSString *)ID
{
    if (!_ID) {
        _ID = @"123";
    }
    return _ID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.bottomView.frame));
    
    LFPerson<LFiOS *> *person = [LFPerson new];
    person.language = [LFiOS new];
    
    LFPerson<LFJava *> *person1 = [LFPerson new];
    person1.language = [LFJava new];
    
    LFPerson<LFLanguage *> *person2 = [LFPerson new];
    person2.language = [LFLanguage new];
    
    person1 = person2;
    
    /**
     __kindof
     */
    
    LFSon *son = [LFSon person];
    NSLog(@"%@", son);
}

- (nullable NSString *)testName:(nullable NSString *)name {
    return name;
}

#pragma mark -
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat headY = CGRectGetMaxY(self.headView.frame);
    if (offsetY > headY) {
        CGRect toolF = self.toolView.frame;
        toolF.origin.y = 0;
        self.toolView.frame = toolF;
        [self.view addSubview:self.toolView];
    }else {
        CGRect toolF = self.toolView.frame;
        toolF.origin.y = 140;
        self.toolView.frame = toolF;
        [self.scrollView insertSubview:self.toolView aboveSubview:self.headView];
    }
    
    if (offsetY < 0) {
        CGFloat scale = 1 - offsetY/70;
        self.headView.transform = CGAffineTransformMakeScale(scale, scale);
    }
}

@end
