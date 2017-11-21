//
//  ViewController.m
//  ImagePicker
//
//  Created by 刘丰 on 2017/11/14.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import "LFPickerPhotoView.h"
#import "LFImagePickerController.h"

@interface ViewController ()<LFPickerPhotoViewDataSource, LFPickerPhotoViewDelegate, LFImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic,weak) LFPickerPhotoView *photoView;

/** 选择的图片模型 */
@property(nonatomic,strong) NSMutableArray<LFAssetModel *> *selectAssetMs;

/** 选中的缩略图 */
@property(nonatomic,strong) NSMutableArray<LFPublicModel *> *selectPublicMs;


@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (NSMutableArray<LFAssetModel *> *)selectAssetMs
{
    if (!_selectAssetMs) {
        _selectAssetMs = [NSMutableArray array];
    }
    return _selectAssetMs;
}

- (NSMutableArray<LFPublicModel *> *)selectPublicMs
{
    if (!_selectPublicMs) {
        _selectPublicMs = [NSMutableArray array];
    }
    return _selectPublicMs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LFPickerPhotoView *pView = [[LFPickerPhotoView alloc] initWithFrame:CGRectMake(15, 30, self.view.frame.size.width - 30, 200)];
    pView.delegate = self;
    pView.dataSource = self;
    [self.view addSubview:pView];
    self.photoView = pView;
    
    __weak typeof(self) weakSelf = self;
    pView.lfPickerPhotoViewFitSize = ^(CGSize size) {
        weakSelf.photoView.frame = CGRectMake(15, 30, self.view.frame.size.width - 30, size.height);
    };
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"monitor" ofType:@"html"]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    self.webView.hidden = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [[LFImageManager manager] imageDatas:self.selectAssetMs completion:^(NSArray<NSData *> *imageDatas) {
        NSLog(@"%zd", imageDatas.count);
    }];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark -
#pragma mark - LFPickerPhotoViewDelegate
- (void)pickerPhotoViewAdd:(LFPickerPhotoView *)photoView
{
    LFImagePickerController *pickerVC = [[LFImagePickerController alloc] init];
    pickerVC.delegate = self;
    pickerVC.assets = self.selectAssetMs;
    pickerVC.publics = self.selectPublicMs;
    [self presentViewController:pickerVC animated:YES completion:nil];
}

- (void)pickerPhotoView:(LFPickerPhotoView *)photoView didSelectAtIndex:(NSUInteger)index
{
    LFImagePickerController *previewVC = [[LFImagePickerController alloc] initPreviewWithAssets:self.selectAssetMs publics:self.selectPublicMs index:index];
    previewVC.delegate = self;
    [self presentViewController:previewVC animated:YES completion:nil];
}

- (void)pickerPhotoView:(LFPickerPhotoView *)photoView didDeleteAtIndex:(NSUInteger)index
{
    [self.selectPublicMs removeObjectAtIndex:index];
    [self.selectAssetMs removeObjectAtIndex:index];
}

#pragma mark -
#pragma mark - LFImagePickerControllerDelegate
- (void)imagePickerController:(LFImagePickerController *)picker didFinishPickingAssets:(NSArray<LFAssetModel *> *)assetMs publics:(NSArray<LFPublicModel *> *)publicMs
{
    self.selectAssetMs = assetMs.mutableCopy;
    self.selectPublicMs = publicMs.mutableCopy;
    self.photoView.publicMs = publicMs;
}

- (NSUInteger)pickerPhotoViewMaxCount:(LFPickerPhotoView *)photoView
{
    return 9;
}

@end
