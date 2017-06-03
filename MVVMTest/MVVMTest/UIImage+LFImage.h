//
//  UIImage+LFImage.h
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/3.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIImage (LFImage)

+ (__kindof UIImage *)lf_imageNamed:(NSString *)imageName;

@end
NS_ASSUME_NONNULL_END
