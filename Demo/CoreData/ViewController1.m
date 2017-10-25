//
//  ViewController.m
//  CoreData
//
//  Created by 刘丰 on 2017/10/18.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController1.h"
#import <CoreData/CoreData.h>
#import "Employee+CoreDataClass.h"
#import "Department+CoreDataClass.h"

@interface ViewController1 ()

@property(nonatomic,strong) NSManagedObjectContext *context;

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 模型文件 -> 数据库
    // 实体 -> 表
    // 实体类 -> 一条数据
    
    [self setupContext];
}

- (IBAction)insert:(id)sender {
    NSArray *names = @[@"iOS", @"Android", @"PHP", @"HTML", @"java", @".net", @"swift"];
    
    
    for (NSInteger i = 0; i < 100; i ++) {
        
        //员工
        Employee *emp = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.context];
        emp.name = [NSString stringWithFormat:@"employee%zd", random()];
        emp.age = arc4random()%140 + 1;
        emp.height = (arc4random()%230 + 50)*1.0/100;
        
        //部门
        Department *dep = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:self.context];
        dep.name = names[arc4random()%7];
        dep.createDate = [NSDate date];
        dep.departNO = [NSString stringWithFormat:@"%6d", arc4random()%100000 + 1];
        
        emp.depart = dep;
        
        NSError *error;
        [self.context save:&error];
        
        if (error) {
            NSLog(@"saveError-%@", error);
        }
    }
}

- (IBAction)deleted:(id)sender {
    
    // 先查询
    NSFetchRequest *request = Employee.fetchRequest;
    request.predicate = [NSPredicate predicateWithFormat:@"age > 140"];
    NSArray *result = [self.context executeFetchRequest:request error:nil];
    
    // 删除
    for (Employee *emp in result) {
        [self.context deleteObject:emp];
    }
    
    // 同步数据库
    [self.context save:nil];
}

- (IBAction)update:(id)sender {
    NSFetchRequest *request = Employee.fetchRequest;
    request.predicate = [NSPredicate predicateWithFormat:@"height > 300"];
    
    NSArray *arr = [self.context executeFetchRequest:request error:nil];
    
    for (Employee *emp in arr) {
        emp.height = 170;
    }
    
    [self.context save:nil];
}

- (IBAction)query:(id)sender {
    
    NSFetchRequest *request = Employee.fetchRequest;
    request.predicate = [NSPredicate predicateWithFormat:@"depart.name = %@", @"iOS"];
    request.fetchOffset = 0;
    request.fetchLimit = 100;
    
    NSError *error;
    NSArray *arr = [self.context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"query-%@", error);
    }else {
        for (Employee *emp in arr) {
            NSLog(@"%@-%d-%.f-%@", emp.name, emp.age, emp.height, emp.depart.name);
        }
    }
}

- (IBAction)filterQuery:(id)sender {
    NSFetchRequest *request = Employee.fetchRequest;
    
    // beginswith
    // endswith
    // containswith
    // like
    request.predicate = [NSPredicate predicateWithFormat:@"name like '*ee17*'"];
    NSArray *arr = [self.context executeFetchRequest:request error:nil];
    for (Employee *emp in arr) {
        NSLog(@"%@-%d-%.f", emp.name, emp.age, emp.height);
    }
}

- (void)setupContext
{
    // 创建上下文
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];// 传nil，则会关联main bundle中所有的模型文件
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    NSString *sqlPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"company.sqlite"];
    
    // 设置数据库的位置
    NSError *error;
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlPath] options:nil error:&error];
    if (error) {
        NSLog(@"coordinator-%@", error);
    }
    context.persistentStoreCoordinator = coordinator;// 持久化存储
    
    self.context = context;
}

@end
