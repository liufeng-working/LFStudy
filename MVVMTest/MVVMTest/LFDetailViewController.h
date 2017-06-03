//
//  LFDetailViewController.h
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/2.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFDetailViewModel.h"

@interface LFDetailViewController : UIViewController

@property(nonatomic,strong) LFDetailViewModel *detailVM;

@end
