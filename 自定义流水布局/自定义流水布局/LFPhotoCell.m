//
//  LFPhotoCell.m
//  自定义流水布局
//
//  Created by 刘丰 on 2017/6/4.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFPhotoCell.h"
#import "UIImageView+WebCache.h"

@interface LFPhotoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LFPhotoCell

- (void)setUrl:(NSURL *)url
{
    _url = url;
    
    [self.imageView sd_setImageWithURL:url];
}

@end
