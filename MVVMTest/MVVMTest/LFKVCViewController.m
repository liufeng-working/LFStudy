//
//  LFKVCViewController.m
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/3.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFKVCViewController.h"
#import "LFFilmModel.h"
#import "NSObject+LFOBJC.h"

@interface LFKVCViewController ()

@end

@implementation LFKVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *movieP = [[NSBundle mainBundle] pathForResource:@"movie.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:movieP];
    NSArray *movies = dict[@"subjects"];
    
    NSMutableArray<LFFilmModel *> *arr = [NSMutableArray array];
    for (NSDictionary *dic in movies) {
        LFFilmModel *film = [LFFilmModel modelWithDic:dic];
        [arr addObject:film];
    }
    
    [arr enumerateObjectsUsingBlock:^(LFFilmModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj.title);
    }];
}

@end
