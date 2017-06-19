//
//  LFDrawingViewController.m
//  LFGraphics
//
//  Created by 刘丰 on 2017/6/16.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFDrawingViewController.h"
#import "LFDrawView.h"
#import "LFHandleView.h"

@interface LFDrawingViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, LFHandleViewDelegete>

@property (weak, nonatomic) IBOutlet LFDrawView *drawView;

@end

@implementation LFDrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIToolbar
}

- (IBAction)clear:(id)sender {
    [self.drawView clear];
}

- (IBAction)revoke:(id)sender {
    [self.drawView revoke];
}

- (IBAction)eraser:(id)sender {
    [self.drawView eraser];
}

- (IBAction)photo:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self showDetailViewController:imagePicker sender:nil];
}

- (IBAction)save:(id)sender {
    UIGraphicsBeginImageContextWithOptions(self.drawView.bounds.size, NO, 0);
    [self.drawView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    UIGraphicsEndImageContext();
}

- (IBAction)valueChange:(UISlider *)sender {
    [self.drawView setLineWidth:sender.value];
}

- (IBAction)setColor:(UIButton *)sender {
    [self.drawView setColor:sender.backgroundColor];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"%@", image);
}

#pragma mark -
#pragma mark - <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    LFHandleView *handleV = [[LFHandleView alloc] initWithFrame:self.drawView.frame];
    handleV.backgroundColor = [UIColor clearColor];
    handleV.image = image;
    handleV.delegate = self;
    [self.view addSubview:handleV];
}

#pragma mark -
#pragma mark - LFHandleViewDelegete
- (void)handleView:(LFHandleView *)handleView newImage:(UIImage *)newImage
{
    self.drawView.image = newImage;
}

@end
