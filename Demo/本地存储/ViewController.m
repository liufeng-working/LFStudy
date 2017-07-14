//
//  ViewController.m
//  本地存储
//
//  Created by 刘丰 on 2017/7/13.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import "LFPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileP = [path stringByAppendingPathComponent:@"data"];
    
    LFPerson *pp = [[LFPerson alloc] init];
    pp.name = @"liufeng";
    pp.age = 25;
    
    [NSKeyedArchiver archiveRootObject:pp toFile:fileP];
}

- (IBAction)save:(id)sender
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileP = [path stringByAppendingPathComponent:@"date.plist"];
    
    NSLog(@"%@", fileP);
    
    NSArray *data = @[@"liufeng", @"love", @"chenbei"];
    [data writeToFile:fileP atomically:YES];
    
    fileP = [path stringByAppendingPathComponent:@"dateDic.plist"];
    NSDictionary *dataDic = @{@"key": @"value"};
    [dataDic writeToFile:fileP atomically:YES];
}

- (IBAction)fetch:(id)sender
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileP = [path stringByAppendingPathComponent:@"data"];
    
    LFPerson *pp = [NSKeyedUnarchiver unarchiveObjectWithFile:fileP];
    NSLog(@"%@", pp);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
