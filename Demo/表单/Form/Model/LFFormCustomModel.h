//
//  LFFormCustomModel.h
//  表单
//
//  Created by 刘丰 on 2017/10/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

/// left:nil right:nil
@interface LFFormCustomModel : NSObject

/**
 自定义视图
 */
@property(nonatomic,strong) UIView *customView;

/**
 自定义视图高度
 */
@property(nonatomic,assign) CGFloat height;

@end
