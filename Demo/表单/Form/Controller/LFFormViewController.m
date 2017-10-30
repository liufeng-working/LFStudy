//
//  LFFormViewController.m
//  LFStudy
//
//  Created by 刘丰 on 2017/9/4.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFFormViewController.h"
#import <Photos/Photos.h>
#import "LFFormTool.h"
#import "LFFormHeaderFooterView.h"
#import "LFFormTextFieldCell.h"
#import "LFFormSwitchCell.h"
#import "LFFormCustomCell.h"
#import "LFFormSelectCell.h"
#import "LFFormPhotoCell.h"

@interface UIViewController (form)

- (void)lfForm_showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle sureTitle:(NSString *)sureTitle sureComplete:(void(^)(void))sureAction;
- (void)lfForm_showImagePickerWithComplete:(void(^)(UIImagePickerControllerSourceType sourceType))com;

@end

@interface LFFormViewController ()<UITableViewDelegate, UITableViewDataSource, LFFormPhotoCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LFFormTextFieldCellDelegate>

@property(nonatomic,weak) LFFormPhotoCell *photoCell;

@property(nonatomic,strong) NSMutableArray<LFFormTextFiledModel *> *tfMs;

@property(nonatomic,strong) NSMutableArray<NSIndexPath *> *indexPaths;

@end

@implementation LFFormViewController

- (NSMutableArray<LFFormTextFiledModel *> *)tfMs
{
    if (!_tfMs) {
        _tfMs = [NSMutableArray array];
    }
    return _tfMs;
}

- (NSMutableArray<NSIndexPath *> *)indexPaths
{
    if (!_indexPaths) {
        _indexPaths = [NSMutableArray array];
    }
    return _indexPaths;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

#pragma mark -
#pragma mark - 给模型赋值，刷新表格
- (void)setGroupMs:(NSArray<LFFormGroupModel *> *)groupMs
{
    _groupMs = groupMs;

    [self.tableView reloadData];
    
    // 过滤出LFFormTextFiledModel 供后面使用
    [self.tfMs removeAllObjects];
    [self.indexPaths removeAllObjects];
    [groupMs enumerateObjectsUsingBlock:^(LFFormGroupModel * _Nonnull groupM, NSUInteger section, BOOL * _Nonnull stop) {
        [groupM.rowMs enumerateObjectsUsingBlock:^(NSObject * _Nonnull rowM, NSUInteger row, BOOL * _Nonnull stop) {
            if ([rowM isKindOfClass:[LFFormTextFiledModel class]]) {
                [self.tfMs addObject:(LFFormTextFiledModel *)rowM];
                [self.indexPaths addObject:[NSIndexPath indexPathForRow:row inSection:section]];
            }
        }];
    }];
}

#pragma mark -
#pragma mark - 初始化UI
- (void)setupUI
{
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.tableFooterView = UIView.new;
    self.tableView.allowsSelection = NO;
}

#pragma mark -
#pragma mark - 

#pragma mark -
#pragma mark - LFFormPhotoCellDelegate
- (void)photoCellAddPhoto:(LFFormPhotoCell *)cell
{
    self.photoCell = cell;
    
    [self lfForm_showImagePickerWithComplete:^(UIImagePickerControllerSourceType sourceType) {
        
        void(^jumoFail)(void) = ^{
            [self lfForm_showAlertViewWithTitle:@"温馨提示" message:@"无法跳转到设置页面，请手动前往设置" cancelTitle:nil sureTitle:@"知道了" sureComplete:nil];
        };
        
        if (sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum) {
            if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusDenied) {
                [self lfForm_showAlertViewWithTitle:@"温馨提示" message:@"相册访问受限，请先设置相册权限" cancelTitle:@"算了" sureTitle:@"去设置" sureComplete:^{
                    [LFFormTool jumpToSetting:jumoFail];
                }];
                return ;
            }
            
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
                [self lfForm_showAlertViewWithTitle:@"温馨提示" message:@"相册不可用" cancelTitle:nil sureTitle:@"知道了" sureComplete:nil];
                return;
            }
        }
        
        if (sourceType == UIImagePickerControllerSourceTypeCamera) {
            if ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusDenied) {
                [self lfForm_showAlertViewWithTitle:@"温馨提示" message:@"相机使用受限，请先设置相机权限" cancelTitle:@"算了" sureTitle:@"去设置" sureComplete:^{
                    [LFFormTool jumpToSetting:jumoFail];
                }];
                return ;
            }
            
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [self lfForm_showAlertViewWithTitle:@"温馨提示" message:@"相机不可用" cancelTitle:nil sureTitle:@"知道了" sureComplete:nil];
                return;
            }
        }
        
        UIImagePickerController *pickerC = [[UIImagePickerController alloc] init];
        pickerC.delegate = self;
        pickerC.allowsEditing = YES;
        pickerC.sourceType = sourceType;
        [self presentViewController:pickerC animated:YES completion:nil];
    }];
}

#pragma mark -
#pragma mark - LFFormTextFieldCellDelegate
- (void)textFieldCellDidClickReturn:(LFFormTextFieldCell *)tfCell
{
    // 跳到下一个输入框
    NSInteger index = [self.tfMs indexOfObject:tfCell.tfM] + 1;
    if (index >= self.tfMs.count) { return; }
    
    NSIndexPath *indexPath = self.indexPaths[index];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"section = %d and row = %d", indexPath.section, indexPath.row];
    NSInteger count = [self.tableView.indexPathsForVisibleRows filteredArrayUsingPredicate:predicate].count;
    if (count == 0) {
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    };
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell becomeFirstResponder];
}

#pragma mark -
#pragma mark - 表代理 UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groupMs.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupMs[section].rowMs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSObject *rowM = self.groupMs[indexPath.section].rowMs[indexPath.row];
    if ([rowM isKindOfClass:[LFFormTextFiledModel class]]) {
        LFFormTextFieldCell *cell = [LFFormTextFieldCell textFieldCellWithTableView:tableView];
        cell.tfM = (LFFormTextFiledModel *)rowM;
        cell.delegate = self;
        return cell;
    }else if ([rowM isKindOfClass:[LFFormSwitchModel class]]) {
        LFFormSwitchCell *cell = [LFFormSwitchCell switchCellWithTableView:tableView];
        cell.sM = (LFFormSwitchModel *)rowM;
        return cell;
    }else if ([rowM isKindOfClass:[LFFormCustomModel class]]) {
        LFFormCustomCell *cell = [LFFormCustomCell customCellWithTableView:tableView];
        cell.cM = (LFFormCustomModel *)rowM;
        return cell;
    }else if ([rowM isKindOfClass:[LFFormSelectModel class]]) {
        LFFormSelectCell *cell = [LFFormSelectCell selectCellWithTableView:tableView];
        cell.sM = (LFFormSelectModel *)rowM;
        return cell;
    }else if ([rowM isKindOfClass:[LFFormPhotoModel class]]) {
        LFFormPhotoCell *cell = [LFFormPhotoCell photoCellWithTableView:tableView];
        cell.delegate = self;
        cell.pM = (LFFormPhotoModel *)rowM;
        return cell;
    }else {
        static NSString *lfTableViewCell_id = @"UITableViewCell_default";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:lfTableViewCell_id];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lfTableViewCell_id];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@", indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LFFormHeaderFooterView *headerView = [LFFormHeaderFooterView formHeaderFooterViewWithTableView:tableView];
    headerView.headerFooterM = self.groupMs[section].headerM;
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    LFFormHeaderFooterView *footerView = [LFFormHeaderFooterView formHeaderFooterViewWithTableView:tableView];
    footerView.headerFooterM = self.groupMs[section].footerM;
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.groupMs[section].headerM.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.groupMs[section].footerM.height;
}

#pragma mark -
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originalImg = info[UIImagePickerControllerOriginalImage];
    [self.photoCell addImage:originalImg];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end

@implementation UIViewController (form)

- (void)lfForm_showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle sureTitle:(NSString *)sureTitle sureComplete:(void(^)(void))sureAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelTitle) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
        [cancel setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [alert addAction:cancel];
    }
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        if (sureAction) {
            sureAction();
        }
    }];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)lfForm_showImagePickerWithComplete:(void(^)(UIImagePickerControllerSourceType sourceType))com
{
    [self.view endEditing:YES];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [cancel setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alert addAction:cancel];
    
    [@[@"相册", @"相机"] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIAlertAction *allAction = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (com) {
                com(idx == 0 ? UIImagePickerControllerSourceTypeSavedPhotosAlbum : UIImagePickerControllerSourceTypeCamera);
            }
        }];
        
        [allAction setValue:[UIColor orangeColor] forKey:@"titleTextColor"];
        [alert addAction:allAction];
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
