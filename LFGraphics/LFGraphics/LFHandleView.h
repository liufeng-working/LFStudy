//
//  LFHandleView.h
//  LFGraphics
//
//  Created by 刘丰 on 2017/6/17.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFHandleViewDelegete;
@interface LFHandleView : UIView

@property(nonatomic,strong) UIImage *image;

@property(nonatomic,weak) id<LFHandleViewDelegete> delegate;

@end

@protocol LFHandleViewDelegete <NSObject>

- (void)handleView:(LFHandleView *)handleView newImage:(UIImage *)newImage;

@end
