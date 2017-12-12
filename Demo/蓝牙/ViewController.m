//
//  ViewController.m
//  蓝牙
//
//  Created by 刘丰 on 2017/11/29.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import <GameKit/GameKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

static NSString *const lfServiceType = @"test";
static NSString *const lfDisplayName = @"chenbei";
@interface ViewController ()<MCBrowserViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MCSessionDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property(nonatomic,strong) MCSession *session;

@property(nonatomic,strong) MCAdvertiserAssistant *ad;

@property(nonatomic,strong) MCPeerID *otherPeerID;

@end

@implementation ViewController

- (MCSession *)session
{
    if (!_session) {
        MCPeerID *peerID = [[MCPeerID alloc] initWithDisplayName:lfDisplayName];
        _session = [[MCSession alloc] initWithPeer:peerID];
        _session.delegate = self;
    }
    return _session;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MCAdvertiserAssistant *ad = [[MCAdvertiserAssistant alloc] initWithServiceType:lfServiceType discoveryInfo:nil session:self.session];
    [ad start];
    self.ad = ad;
}

- (IBAction)search:(id)sender {
    
    // < iOS7.0
//    GKPeerPickerController *peerVC = [[GKPeerPickerController alloc] init];
//    [peerVC show];
    
    MCBrowserViewController *bVC = [[MCBrowserViewController alloc] initWithServiceType:lfServiceType session:self.session];
    bVC.delegate = self;
    [self presentViewController:bVC animated:YES completion:nil];
}

- (IBAction)select:(id)sender {
    UIImagePickerController *imgPickerVC = [[UIImagePickerController alloc] init];
    imgPickerVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imgPickerVC.delegate = self;
    [self presentViewController:imgPickerVC animated:YES completion:nil];
    
}

- (IBAction)send:(id)sender {
    if (self.imageView.image == nil) { return; }
    
    NSData *imgData = UIImageJPEGRepresentation(self.imageView.image, 0.1);
    NSError *error = nil;
    BOOL result = [self.session sendData:imgData toPeers:@[self.otherPeerID] withMode:MCSessionSendDataUnreliable error:&error];
    if (result && !error) {
        NSLog(@"发送成功");
    }else if (error){
        NSLog(@"%@", error);
    }else {
        NSLog(@"发送失败");
    }
}

#pragma mark -
#pragma mark - MCBrowserViewControllerDelegate
// Notifies the delegate, when the user taps the done button.
- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController {
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}

// Notifies delegate that the user taps the cancel button.
- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController {
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}

// Notifies delegate that a peer was found; discoveryInfo can be used to
// determine whether the peer should be presented to the user, and the
// delegate should return a YES if the peer should be presented; this method
// is optional, if not implemented every nearby peer will be presented to
// the user.
- (BOOL)browserViewController:(MCBrowserViewController *)browserViewController shouldPresentNearbyPeer:(MCPeerID *)peerID withDiscoveryInfo:(nullable NSDictionary<NSString *, NSString *> *)info {
    self.otherPeerID = peerID;
    return YES;
}

#pragma mark -
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        self.imageView.image = info[UIImagePickerControllerOriginalImage];
    }];
}

#pragma mark -
#pragma mark - MCSessionDelegate
// Remote peer changed state.
- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    
}

// Received data from remote peer.
- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    
    if (data) {
        self.imageView.image = [UIImage imageWithData:data];
    }
}

// Received a byte stream from remote peer.
- (void)    session:(MCSession *)session
   didReceiveStream:(NSInputStream *)stream
           withName:(NSString *)streamName
           fromPeer:(MCPeerID *)peerID {
    
}

// Start receiving a resource from remote peer.
- (void)                    session:(MCSession *)session
  didStartReceivingResourceWithName:(NSString *)resourceName
                           fromPeer:(MCPeerID *)peerID
                       withProgress:(NSProgress *)progress {
    
}

// Finished receiving a resource from remote peer and saved the content
// in a temporary location - the app is responsible for moving the file
// to a permanent location within its sandbox.
- (void)                    session:(MCSession *)session
 didFinishReceivingResourceWithName:(NSString *)resourceName
                           fromPeer:(MCPeerID *)peerID
                              atURL:(nullable NSURL *)localURL
                          withError:(nullable NSError *)error {
    
}

@end
