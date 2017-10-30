//
//  LFFormTool.m
//  表单
//
//  Created by 刘丰 on 2017/10/26.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFFormTool.h"

@implementation LFFormTool

+ (NSString *)resourcePathWithNamed:(NSString *)name
{
    return [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@2x", name] ofType:@"png" inDirectory:@"LFFormResource.bundle"];
}

+ (UIImage *)imageWithNamed:(NSString *)name
{
    return [UIImage imageWithContentsOfFile:[self resourcePathWithNamed:name]];
}

+ (UIImage *)deleteImage
{
    return [self imageWithNamed:@"lfFormAddPhoto_delete"];
}

+ (UIImage *)addImage
{
    return [self imageWithNamed:@"lfFormAddPhoto_add"];
}

+ (void)jumpToSetting:(void(^)(void))failure
{
    UIApplication *app = [UIApplication sharedApplication];
    NSURL *settingUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([app canOpenURL:settingUrl]) {
        if ([app respondsToSelector:@selector(openURL:)]) {                            [app openURL:settingUrl];
        }else {
            [app openURL:settingUrl options:@{} completionHandler:^(BOOL success) {
                if (!success && failure) {
                    failure();
                }
            }];
        }
    }else {
        if (failure) {
            failure();
        }
    }
}

@end
