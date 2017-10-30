//
//  LFFormPhotoModel.m
//  表单
//
//  Created by 刘丰 on 2017/10/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFFormPhotoModel.h"

@implementation LFFormPhotoModel

- (NSUInteger)maxCount
{
    return _maxCount > 0 ? _maxCount : 3;
}

- (NSMutableArray<UIImage *> *)images
{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

@end
