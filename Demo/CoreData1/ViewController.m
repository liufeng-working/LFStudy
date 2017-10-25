//
//  ViewController.m
//  CoreData1
//
//  Created by 刘丰 on 2017/10/19.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "LFEmployee+CoreDataClass.h"
#import "LFDepartment+CoreDataClass.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupContext];
    
//    NSFetchedResultsController
//    NSEntityMigrationPolicy
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willSave) name:NSManagedObjectContextWillSaveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSave) name:NSManagedObjectContextDidSaveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChange) name:NSManagedObjectContextObjectsDidChangeNotification object:nil];
}

- (void)willSave
{
    NSLog(@"%s", __func__);
}

- (void)didSave
{
    NSLog(@"%s", __func__);
}

- (void)didChange
{
    NSLog(@"%s", __func__);
}

- (NSManagedObjectContext *)context
{
    return ((AppDelegate *)[UIApplication sharedApplication].delegate).context;
}

- (IBAction)insert:(id)sender {
    
    NSArray *departs = @[@"iOS", @"Android", @"PHP", @"HTML", @"java", @".net", @"swift"];
    NSArray *names = @[@"q", @"w", @"e", @"r", @"t", @"y", @"u", @"i", @"o", @"J", @"p", @"a", @"s", @"d", @"f", @"g", @"h", @"k", @"Q", @"l", @"z", @"K", @"x", @"c", @"v", @"b", @"n", @"m", @"D", @"G", @"F", @"H", @"L", @"P", @"O", @"I", @"U", @"M", @"a", @"N", @"B", @"V", @"C", @"X", @"Z", @"A", @"S", @"Y", @"R", @"T"];
    
    for (NSInteger i = 0; i < 1; i ++) {
        // 创建托管对象，并指明创建的托管对象所属实体名
        LFEmployee *emp = [NSEntityDescription insertNewObjectForEntityForName:@"LFEmployee" inManagedObjectContext:self.context];
        emp.name = [NSString stringWithFormat:@"%@%zd", names[arc4random()%50], arc4random()%11];
        emp.age = arc4random()%140 + 1;
//        emp.height = (arc4random()%230 + 50)*1.0/100;
        emp.height = 2.30;
        emp.sectionName = @"test";
        emp.version = @"1.0.0";
        
        //部门
        LFDepartment *dep = [NSEntityDescription insertNewObjectForEntityForName:@"LFDepartment" inManagedObjectContext:self.context];
        dep.name = departs[arc4random()%7];
        dep.createDate = [NSDate date];
        dep.iD = [NSString stringWithFormat:@"%6d", arc4random()%100000 + 1];
        
        emp.depart = dep;
        
    }
    
    // 通过上下文保存对象，并在保存前判断是否有更改
    if (self.context.hasChanges) {
        NSError *error;
        [self.context save:&error];
        if (error) {
            NSLog(@"saveError-%@", error);
        }
    }
}

- (IBAction)deleted:(id)sender {
//    NSBatchDeleteRequest 批量删除
    // 建立获取数据的请求对象，指明对LFEmployee实体进行删除操作
    NSFetchRequest *request = LFEmployee.fetchRequest;
    
    // 创建谓词对象，过滤出符合要求的对象，也就是要删除的对象
    request.predicate = [NSPredicate predicateWithFormat:@"age > 140"];
    
    // 执行获取操作，找到要删除的对象
    NSArray *result = [self.context executeFetchRequest:request error:nil];
    
    // 删除
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.context deleteObject:obj];
    }];
    [self.context deletedObjects];
    
    // 同步数据库
    if (self.context.hasChanges) {
        [self.context save:nil];
    }
}

- (IBAction)batchDelete:(id)sender {
    
    // 创建请求对象，并指明对Employee表做操作
    NSFetchRequest *re = [NSFetchRequest fetchRequestWithEntityName:@"LFEmployee"];
    
    // 通过谓词设置过滤条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like 'a*'"];
    re.predicate = predicate;
    
    // 创建批量删除请求，并使用上面创建的请求对象当做参数进行初始化
    NSBatchDeleteRequest *request = [[NSBatchDeleteRequest alloc] initWithFetchRequest:re];
    
    // 设置请求结果类型，设置为受影响对象的Count
    request.resultType = NSBatchDeleteResultTypeCount;
    
    // 使用NSBatchDeleteResult对象来接受返回结果，通过id类型的属性result获取结果
    NSPersistentStoreResult *result = [self.context executeRequest:request error:nil];
    
    // 更新MOC中的托管对象，使MOC和本地持久化区数据同步
    [self.context refreshAllObjects];
    
    NSLog(@"%@", result);
}

- (IBAction)update:(id)sender {
    
//    NSBatchUpdateRequest 批量更新
    
    // 建立获取数据的请求对象，并指明操作
    NSFetchRequest *request = LFEmployee.fetchRequest;
    
    // 创建谓词对象，设置过滤条件
    request.predicate = [NSPredicate predicateWithFormat:@"height > 2"];
    
    // 执行获取请求，获取到符合要求的托管对象
    NSArray *arr = [self.context executeFetchRequest:request error:nil];
    
    for (LFEmployee *emp in arr) {
        emp.height = 170;
    }
    
    // 将上面的修改进行存储
    if (self.context.hasChanges) {
        [self.context save:nil];
    }
}

- (IBAction)batchUpdate:(id)sender {
    
    // 创建批量更新对象，并指明操作Employee表
    NSBatchUpdateRequest *request = [NSBatchUpdateRequest batchUpdateRequestWithEntityName:@"LFEmployee"];
    
    // 设置返回值类型，默认是什么都不返回(NSStatusOnlyResultType)，这里设置返回发生改变的对象Count值
    request.resultType = NSUpdatedObjectsCountResultType;
    
    //设置受影响的范围
    request.predicate = [NSPredicate predicateWithFormat:@"height > 2"];
    
    //设置改变的值
    request.propertiesToUpdate = @{@"height": @2.1};
    
    // 执行请求后，返回值是一个特定的result对象，通过result的属性获取返回的结果
    NSPersistentStoreResult *result = [self.context executeRequest:request error:nil];
    
    // 更新MOC中的托管对象，使MOC和本地持久化区数据同步
    [self.context refreshAllObjects];
    
    NSLog(@"%@", result);
}

- (IBAction)query:(id)sender {
    
    // 建立获取数据的请求对象，指明操作的实体
    NSFetchRequest *request = LFEmployee.fetchRequest;
    request.fetchOffset = 0;
    request.fetchLimit = 100;
    
    // 执行获取操作，获取所有Employee托管对象
    NSError *error;
    NSArray *arr = [self.context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"query-%@", error);
    }else {
        for (LFEmployee *emp in arr) {
            NSLog(@"%@-%d-%f-%@", emp.name, emp.age, emp.height, emp.depart.name);
        }
    }
}

- (IBAction)filterQuery:(id)sender {
    NSFetchRequest *request = LFEmployee.fetchRequest;
    
    // beginswith
    // endswith
    // containswith
    // like
    //复合过滤条件
    //复合方式1
//     NSPredicate *p = [NSPredicate predicateWithFormat:@"(name matches '[a-z][0-5]') and (height > 1.71)"];
    
    //复合方式2
    NSPredicate *p1 = [NSPredicate predicateWithFormat:@"name matches '[a-z][0-5]'"];
    NSPredicate *p2= [NSPredicate predicateWithFormat:@"height > 1.71"];
    request.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[p1, p2]];
    
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:YES];
    request.sortDescriptors = @[sort1];
    
    NSArray *arr = [self.context executeFetchRequest:request error:nil];
    [arr enumerateObjectsUsingBlock:^(LFEmployee *emp, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@-%d-%f", emp.name, emp.age, emp.height);
    }];
}

- (IBAction)operation:(id)sender {
    
    // 创建请求对象
    NSFetchRequest *request = LFEmployee.fetchRequest;
    
    // 设置返回值为字典类型，这是为了结果可以通过设置的name名取出，这一步是必须的
    request.resultType = NSDictionaryResultType;
    
    // 创建描述对象
    NSExpressionDescription *exd = [[NSExpressionDescription alloc] init];
    
    // 设置描述对象的name，最后结果需要用这个name当做key来取出结果
    exd.name = @"sum";
    
    // 设置返回值类型，根据运算结果设置类型
    exd.expressionResultType = NSFloatAttributeType;
    
    // 创建具体描述对象，用来描述对那个属性进行什么运算(可执行的运算类型很多，这里描述的是对height属性，做sum运算)
    NSExpression *exp = [NSExpression expressionForFunction:@"add:to:" arguments:@[[NSExpression expressionForKeyPath:@"height"], [NSExpression expressionForKeyPath:@"age"]]];
    
    // 只能对应一个具体描述对象
    exd.expression = exp;
    
    // 给请求对象设置描述对象，这里是一个数组类型，也就是可以设置多个描述对象
    request.propertiesToFetch = @[exd];
    
    // 执行请求，返回值还是一个数组，数组中只有一个元素，就是存储计算结果的字典
    NSArray *arr = [self.context executeFetchRequest:request error:nil];
    
    // 通过上面设置的name值，当做请求结果的key取出计算结果
    NSLog(@"%@", arr);
}

- (void)setupContext
{
    // 创建上下文对象，并发队列设置为主队列
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    // 创建托管对象模型，并使用Company.momd路径当做初始化参数
    NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:@"Company.momd" withExtension:nil];
    NSManagedObjectModel *modelFile = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
    
    // 创建持久化存储调度器
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:modelFile];
    
    // 创建并关联SQLite数据库文件，如果已经存在则不会重复创建
    NSString *sqlPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"company.sqlite"];
    
//    NSDictionary *option = @{NSMigratePersistentStoresAutomaticallyOption: @(YES),
//         NSInferMappingModelAutomaticallyOption: @(YES)
//                             };
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlPath] options:nil error:nil];
    
    // 为上下文对象设置持久化存储器
    context.persistentStoreCoordinator = coordinator;
    
    ((AppDelegate *)[UIApplication sharedApplication].delegate).context = context;
}

@end
