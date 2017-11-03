//
//  ViewController.m
//  表单
//
//  Created by 刘丰 on 2017/9/4.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.label.lineBreakMode = NSLineBreakByTruncatingTail;
    
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    NSString *str = @"\n多日来，灞桥区的孟先生有点烦：坐出租车时不慎落下了装有驾\n照和几张银行卡的包，出租车司机多方寻找到他，但在归还物品时向他索要了200元。孟先生认为，司机主动归还乘客遗失物值得称赞，但要钱的行为实在不可取。";
    self.label.attributedText = [self imageAttributedStringWithLabel:self.label text:str];
}

- (NSAttributedString *)imageAttributedStringWithLabel:(UILabel *)label text:(NSString *)text
{
    UIFont *font = self.label.font;
    
    CGFloat lineHeight = font.lineHeight;
    CGFloat vailableW = self.label.frame.size.width;
    CGFloat maxLength = vailableW*2 - lineHeight - font.xHeight*3;
    __block CGFloat textLength = 0;
    NSMutableString *string = [NSMutableString string];
    [text enumerateSubstringsInRange:NSMakeRange(0, text.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        CGFloat width = [substring boundingRectWithSize:CGSizeMake(MAXFLOAT, lineHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size.width;
        if ([substring isEqualToString:@"\n"]) {
            if (textLength < vailableW) {// 出现在第一行
                textLength = vailableW;
                [string appendString:substring];
            }else {// 出现在第二行
                CGFloat spaceW = [@" " boundingRectWithSize:CGSizeMake(MAXFLOAT, lineHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size.width;
                
                do {
                    textLength += spaceW;
                    [string appendString:@" "];// 替换为空格
                } while (textLength <= maxLength);
            }
        }else {
            textLength += width;
            if (textLength <= maxLength) {
                [string appendString:substring];
            }else {
                *stop = YES;
            }
        }
    }];
    
    [string appendString:@"..."];// 加省略号
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"delete"];
    attachment.bounds = CGRectMake(0, -4, lineHeight, lineHeight);
    NSAttributedString *image = [NSAttributedString attributedStringWithAttachment:attachment];
    
    NSMutableAttributedString *attMStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attMStr appendAttributedString:image];
    
    return attMStr;
}

@end


/**
 论坛-技术支持-帖子 为标题增加图片
 */
@interface NSString (postImage)

- (NSAttributedString *)appendImageWithAvailableWidth:(CGFloat)width font:(UIFont *)font;

@end

@implementation NSString (postImage)

- (NSAttributedString *)appendImageWithAvailableWidth:(CGFloat)width font:(UIFont *)font
{
    UIImage *img = [UIImage imageNamed:@"forum_dis_previewImg"];
    CGFloat lineHeight = font.lineHeight;
    CGFloat imgW = [LFFit fitWidthForHeight:lineHeight targetSize:img.size];
    CGFloat maxLength = width*2 - imgW - font.xHeight*3;
    NSMutableString *string = [NSMutableString string];
    
    CGFloat allW = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, lineHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size.width;
    if (allW <= maxLength) {
        [string appendString:self];
    }else {
        __block CGFloat textLength = 0;
        [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
            CGFloat w = [substring boundingRectWithSize:CGSizeMake(MAXFLOAT, lineHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size.width;
            if ([substring isEqualToString:@"\n"]) {
                if (textLength < w) {// 出现在第一行
                    textLength = w;
                    [string appendString:substring];
                }else {// 出现在第二行
                    NSString *space = @" ";
                    CGFloat spaceW = [space boundingRectWithSize:CGSizeMake(MAXFLOAT, lineHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size.width;
                    do {
                        textLength += spaceW;
                        [string appendString:space];// 替换为空格
                    } while (textLength <= maxLength);
                }
            }else {
                textLength += w;
                if (textLength <= maxLength) {
                    [string appendString:substring];
                }else {
                    *stop = YES;
                }
            }
        }];
        
        if (textLength > maxLength) {
            [string appendString:@"..."];// 加省略号
        }
    }
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = img;
    attachment.bounds = CGRectMake(0, -4, imgW, lineHeight);
    NSAttributedString *image = [NSAttributedString attributedStringWithAttachment:attachment];
    
    NSMutableAttributedString *attMStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attMStr appendAttributedString:image];
    
    return attMStr;
}

@end

