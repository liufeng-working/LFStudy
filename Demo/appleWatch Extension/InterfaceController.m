//
//  InterfaceController.m
//  appleWatch Extension
//
//  Created by 刘丰 on 2017/11/29.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *interfaceL;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



