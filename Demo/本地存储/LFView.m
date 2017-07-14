//
//  LFView.m
//  LFStudy
//
//  Created by 刘丰 on 2017/7/13.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFView.h"

@interface LFView ()

@property (weak, nonatomic) IBOutlet UIButton *save;


@end

@implementation LFView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSLog(@"%@", self);
}

//解析文件时会调用
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"%@", self);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"%s", __func__);
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"%s", __func__);
    }
    return self;
}

@end
