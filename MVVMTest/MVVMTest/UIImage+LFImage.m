//
//  UIImage+LFImage.m
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/3.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "UIImage+LFImage.h"
#import <objc/runtime.h>

@implementation UIImage (LFImage)

+ (void)load
{
    Method originM = class_getClassMethod(self, @selector(imageNamed:));
    Method newM = class_getClassMethod(self, @selector(lf_imageNamed:));
    method_exchangeImplementations(originM, newM);
}

+ (__kindof UIImage *)lf_imageNamed:(NSString *)imageName
{
    UIImage *image = [self lf_imageNamed:imageName];
    if (!image) {
        @throw [NSException exceptionWithName:@"图片为空" reason:[NSString stringWithFormat:@"图片名称为\"%@\"的图片不存在", imageName] userInfo:nil];
    }
    return image;
}

@end
