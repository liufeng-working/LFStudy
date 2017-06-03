//
//  LFMovieCell.m
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/1.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFMovieCell.h"
#import "LFMovieModel.h"
#import "UIImageView+WebCache.h"

@interface LFMovieCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *ratingL;
@property (weak, nonatomic) IBOutlet UILabel *yearL;

@end

@implementation LFMovieCell

+ (instancetype)movieCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"LFMovieCell";
    LFMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"LFMovieCell" owner:nil options:nil].firstObject;
    }
    return cell;
}

- (void)setMovieM:(LFMovieModel *)movieM
{
    _movieM = movieM;
    
    [self.iconView sd_setImageWithURL:movieM.images.medium];
    self.titleL.text = movieM.title;
    self.ratingL.text = movieM.rating.average;
    self.yearL.text = movieM.year;
}

@end
