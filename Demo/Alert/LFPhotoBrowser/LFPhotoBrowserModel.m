//
//  LFPhotoBrowserModel.m
//  LFJXStreet
//
//  Created by 刘丰 on 2017/1/11.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFPhotoBrowserModel.h"

@implementation LFPhotoBrowserModel

+ (instancetype)photoModelWithUrl:(NSURL *)imgUrl
{
    return [self photoModelWithUrl:imgUrl placeholder:nil];
}

+ (instancetype)photoModelWithUrl:(NSURL *)imgUrl
                      placeholder:(UIImage * _Nullable)phImg
{
    LFPhotoBrowserModel *p = [[self alloc] init];
    p.imgUrl = imgUrl;
    p.placeholderImage = phImg;
    return p;
}

+ (instancetype)photoModelWithImage:(UIImage *)image
{
    return [self photoModelWithImage:image placeholder:nil];
}

+ (instancetype)photoModelWithImage:(UIImage *)image
                        placeholder:(UIImage * _Nullable)phImg
{
    LFPhotoBrowserModel *p = [[self alloc] init];
    p.image = image;
    p.placeholderImage = phImg;
    return p;
}

@end
