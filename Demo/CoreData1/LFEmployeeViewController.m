//
//  LFEmployeeViewController.m
//  CoreData1
//
//  Created by 刘丰 on 2017/10/20.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFEmployeeViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "LFEmployee+CoreDataClass.h"

@interface LFEmployeeViewController ()<NSFetchedResultsControllerDelegate>

@property(nonatomic,strong) NSFetchedResultsController *frc;

@end

@implementation LFEmployeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNSFetchedResultContrller];
}

- (NSManagedObjectContext *)context
{
    return ((AppDelegate *)[UIApplication sharedApplication].delegate).context;
}

- (IBAction)insert:(id)sender {
    LFEmployee *emp = [NSEntityDescription insertNewObjectForEntityForName:@"LFEmployee" inManagedObjectContext:self.context];
    emp.name = @"A1";
    emp.age = arc4random()%140 + 1;
    emp.height = (arc4random()%230 + 50)*1.0/100;
    emp.sectionName = @"test";
    if (self.context.hasChanges) {
        [self.context save:nil];
    }
}

- (IBAction)update:(id)sender {

    // 建立获取数据的请求对象，并指明操作
    NSFetchRequest *req = LFEmployee.fetchRequest;
    
    // 创建谓词对象，设置过滤条件
    req.predicate = [NSPredicate predicateWithFormat:@"height > 1.71"];
    
    // 执行获取请求，获取到符合要求的托管对象
    NSArray *arr = [self.context executeFetchRequest:req error:nil];
    
    for (LFEmployee *emp in arr) {
        emp.height = 1.68;
    }
    
    // 将上面的修改进行存储
    if (self.context.hasChanges) {
        [self.context save:nil];
    }
}

- (void)setupNSFetchedResultContrller {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 创建请求对象，并指明操作LFEmployee表
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"LFEmployee"];
        
        // 设置排序规则，指明根据name字段升序排序
        NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        request.sortDescriptors = @[nameSort];
        
        // 创建NSFetchedResultsController控制器实例，并绑定MOC
        NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.context sectionNameKeyPath:@"sectionName" cacheName:nil];
        frc.delegate = self;// 设置代理，并遵守协议
        
        // 执行获取请求，执行后FRC会从持久化存储区加载数据，其他地方可以通过FRC获取数据
        NSError *error;
        [frc performFetch:&error];
        self.frc = frc;
        
        if (error) {
            NSLog(@"NSFetchedResultsController-%@", error);
        }
        
        [self.tableView reloadData];
    });
}

#pragma mark - Table view data source
// 通过FRC的sections数组属性，获取所有section的count值
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.frc.sections.count;
}

// 通过当前section的下标从sections数组中取出对应的section对象，并从section对象中获取所有对象count
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.frc.sections[section].numberOfObjects;
}

// FRC根据indexPath获取托管对象，并给cell赋值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    LFEmployee *emp = [self.frc objectAtIndexPath:indexPath];
    cell.textLabel.text = emp.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d-%.3f", emp.age, emp.height];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.frc.sections[section].indexTitle;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    LFEmployee *emp = [self.frc objectAtIndexPath:indexPath];
    [self.context deleteObject:emp];
    
    if (self.context.hasChanges) {
        [self.context save:nil];
    }
}

#pragma mark -
#pragma mark - NSFetchedResultsControllerDelegate
// Cell数据源发生改变会回调此方法，例如添加新的托管对象等
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(nullable NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(nullable NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            break;
        case NSFetchedResultsChangeUpdate: {
    
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            break;
    }
}

// Section数据源发生改变回调此方法，例如修改section title等。
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    NSLog(@"%s", __func__);
    
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:sectionIndex];
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:set withRowAnimation:UITableViewRowAnimationNone];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:set withRowAnimation:UITableViewRowAnimationNone];
            break;
        case NSFetchedResultsChangeUpdate: {
            
        }
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView deleteSections:set withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertSections:set withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

// 本地数据源发生改变，将要开始回调FRC代理方法。
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

// 本地数据源发生改变，FRC代理方法回调完成。
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

// 返回section的title，可以在这里对title做进一步处理。这里修改title后，对应section的indexTitle属性会被更新。
//- (nullable NSString *)controller:(NSFetchedResultsController *)controller sectionIndexTitleForSectionName:(NSString *)sectionName API_AVAILABLE(macosx(10.12),ios(4.0)) {
//    return @"liufeng";
//}

@end
