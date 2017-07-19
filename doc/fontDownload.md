# 中文字体动态下载

## 功能介绍
使用动态下载中文字体的API可以动态地向iOS系统中添加字体文件，这些字体文件都是下载到系统的目录中（目录是/private/var/mobile/Library/Assets/com_apple_MobileAsset_Font/），所以并不会造成应用体积的增加。并且，由于字体文件是iOS系统提供的，也免去了字体使用版权的问题。虽然第一次下载相关的中文字体需要一些网络开销和下载时间，但是这些字体文件下载后可以在所有应用间共享，所以可以预见到，随着该API使用的普及，大部分应用都不需要提示用户下载字体，因为很可能这些字体在之前就被其它应用下载下来了。

## 字体列表
在苹果官网中，列出了提供动态下载和使用中文字体文件列表。不过，由于下载的时候需要使用的名字是PostScript名称，所以如果你真正要动态下载相应的字体的话，还需要使用Mac内自带的应用“字体册“来获得相应字体的PostScript名称。

不知从OS x哪个版本开始，字体册里只能查看了，不能查看到PostScript名称了。所以看到效果之后，需要在百度一下。

## API介绍--使用
苹果提供的动态下载代码的[Demo工程](https://developer.apple.com/library/content/samplecode/DownloadFont/Introduction/Intro.html#//apple_ref/doc/uid/DTS40013404-Intro-DontLinkElementID_2) 链接在这里。将此Demo工程下载下来，即可学习相应API的使用。下面我对该工程中相应API做简单的介绍。

> 1.假如我们现在要下载娃娃体字体，它的PostScript名称为DFWaWaSC-W5。具体的步骤如下：

```
- (BOOL)isFontDownloaded:(NSString *)fontName {   
//判断是否系统支持某种字体
- (BOOL)isFontDownloaded:(NSString *)fontName {
    UIFont* aFont = [UIFont fontWithName:fontName size:12.0];
    if (aFont && ([aFont.fontName compare:fontName] == NSOrderedSame
                  || [aFont.familyName compare:fontName] == NSOrderedSame)) {
        return YES;
    } else {
        return NO;
    }
}
```

> 2.如果该字体下载过了，则可以直接使用。否则我们需要先准备下载字体API需要的一些参数，如下所示：

```
// 用字体的PostScript名字创建一个Dictionary
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:fontName, kCTFontNameAttribute, nil];
    
    // 创建一个字体描述对象CTFontDescriptorRef
    CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrs);
    
    // 将字体描述对象放到一个NSMutableArray中
    NSMutableArray *descs = [NSMutableArray arrayWithCapacity:0];
    [descs addObject:(__bridge id)desc];
    CFRelease(desc);
```

> 3.准备好上面的descs变量后，则可以进行字体的下载了，代码如下：

```
__block BOOL errorDuringDownload = NO;
    CTFontDescriptorMatchFontDescriptorsWithProgressHandler((__bridge CFArrayRef)descs, NULL, ^bool(CTFontDescriptorMatchingState state, CFDictionaryRef  _Nonnull progressParameter) {
        
        switch (state) {
            case kCTFontDescriptorMatchingDidBegin:
                NSLog(@"匹配成功");
                break;
            case kCTFontDescriptorMatchingDidFinish: {
                NSLog(@"字体%@下载成功", fontName);
                dispatch_sync(dispatch_get_main_queue(), ^{
                    self.label.font = [UIFont fontWithName:fontName size:17];
                });
            }
                break;
            case kCTFontDescriptorMatchingWillBeginDownloading:
                NSLog(@"字体开始下载");
                break;
            case kCTFontDescriptorMatchingDidFinishDownloading: {
                
                NSLog(@"字体下载完成");
                dispatch_sync(dispatch_get_main_queue(), ^{
                    self.label.font = [UIFont fontWithName:fontName size:17];
                });
            }
                break;
            case kCTFontDescriptorMatchingDownloading: {
                double progressValue = [[(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingPercentage] doubleValue];
                NSLog(@"下载中%f", progressValue);
            }
                break;
            default: {
                NSError *error = [(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingError];
                if (errorDuringDownload) {
                    NSLog(@"error%@", error.description);
                }
                
                errorDuringDownload = YES;
            }
                break;
        }
        
        return true;
    });
```