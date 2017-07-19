//
//  ViewController.m
//  网络请求
//
//  Created by 刘丰 on 2017/7/18.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate>

@property(nonatomic,strong) NSMutableData *data;

@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@property(nonatomic,assign) double max;

@property(nonatomic,assign) double current;

@property(nonatomic,strong) NSString *path;

@property(nonatomic,strong) NSFileHandle *handle;

@property(nonatomic,strong) NSURLConnection *connection;

@property(nonatomic,strong)NSOutputStream *output;
@end

@implementation ViewController

- (NSString *)path
{
    if (!_path) {
        
        _path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"beauty.mp4"];
    }
    return _path;
}

- (NSMutableData *)data
{
    if (!_data) {
        _data = [NSMutableData data];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

- (IBAction)start:(id)sender
{
    [self stream];
}

- (IBAction)cancel:(id)sender
{
    self.current = 0;
    [self.connection cancel];
}

#pragma mark -
#pragma mark - 输出流
- (void)stream
{
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark -
#pragma mark - 大文件下载
- (void)downloadBig
{
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    NSString *range = [NSString stringWithFormat:@"byte=%zd-", self.current];
//    [request setValue:range forHTTPHeaderField:@"Range"];
   self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark -
#pragma mark - 小文件下载1
- (void)downloadSmall1
{
    NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/movie/subject/1764796"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark -
#pragma mark - 小文件下载
- (void)downloadSmall
{
    NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/movie/subject/1764796"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        UIImage *image = [UIImage imageWithData:data];
        self.imageview.image = image;
    }];
}

#pragma mark -
#pragma mark - GET请求
- (void)GET
{
    NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/movie/subject/1764796"];
    NSURLResponse *response;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSLog(@"%@", data);

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
       NSLog(@"%@", data);
    }];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

#pragma mark -
#pragma mark - NSURLConnectionDataDelegate
//- (nullable NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(nullable NSURLResponse *)response {
//    
//}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"error:%@", error);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if (self.current > 0) {
        return;
    }
    self.max = response.expectedContentLength;
    
    self.output = [[NSOutputStream alloc] initToFileAtPath:self.path append:YES];
    [self.output open];
    
//    [[NSFileManager defaultManager] createFileAtPath:self.path contents:nil attributes:nil];
//    self.handle = [NSFileHandle fileHandleForWritingAtPath:self.path];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    self.current += data.length;
    CGFloat progress = self.current/self.max;
    NSLog(@"%f", progress);
    
    [self.output write:data.bytes maxLength:data.length];
//    [self.handle seekToEndOfFile];
//    [self.handle writeData:data];
}

//- (nullable NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request {
//    
//}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
    
}

//- (nullable NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
//    
//}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    self.imageview.image = [UIImage imageWithData:self.data];
//    [self.handle closeFile];
//    self.handle = nil;
    [self.output close];
    self.output = nil;
}

#pragma mark -
#pragma mark - POST请求
- (void)POST
{
    NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/movie/in_theaters"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"city=北京" dataUsingEncoding:NSUTF8StringEncoding];
    request.timeoutInterval = 15;
    [request setValue:@"" forHTTPHeaderField:@""];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            NSLog(@"error:%@", connectionError);
        }else {
            
            /*
             NSJSONReadingMutableContainers = (1UL << 0), 可变字典或者数组
             NSJSONReadingMutableLeaves = (1UL << 1), 字典和数组里面的字符串都是可变的
             NSJSONReadingAllowFragments = (1UL << 2), 既不是数组也不是字典，必须使用这个
             */
           id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"%@", result);
        }
    }];
}

@end
