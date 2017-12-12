//
//  LFPhotoBrowserExtraView.h
//  LFJXStreet
//
//  Created by 刘丰 on 2017/1/11.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LFPhotoBrowserExtraViewDelegate;
@interface LFPhotoBrowserExtraView : UIView

@property(nonatomic,assign) NSInteger totle;
@property(nonatomic,assign) NSInteger currentIndex;

@property(nonatomic,weak) id<LFPhotoBrowserExtraViewDelegate> delegate;

/**
 保存按钮是否显示（默认NO）
 */
@property(nonatomic,assign) BOOL saveShow;

@end

@protocol LFPhotoBrowserExtraViewDelegate <NSObject>

@optional
- (void)photoBrowserExtraViewDidClickSave:(LFPhotoBrowserExtraView *)view;

@end

NS_ASSUME_NONNULL_END
