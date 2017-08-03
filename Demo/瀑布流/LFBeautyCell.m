//
//  LFBeautyCell.m
//  LFStudy
//
//  Created by 刘丰 on 2017/8/3.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFBeautyCell.h"
#import "LFBeauty.h"
#import "UIImageView+WebCache.h"

@interface LFBeautyCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LFBeautyCell

- (void)setBeauty:(LFBeauty *)beauty
{
    _beauty = beauty;
    
    [self.imageView sd_setImageWithURL:beauty.imgUrl];
}

@end
