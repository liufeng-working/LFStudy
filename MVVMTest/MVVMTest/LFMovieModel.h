//
//  LFMovieModel.h
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/1.
//  Copyright © 2017年 liufeng. All rights reserved.
//

/*{
 alt = "https://movie.douban.com/subject/1578714/";
 casts = 
 (
 {
 alt = "https://movie.douban.com/celebrity/1002676/";
 avatars =                     
 {
 large = "https://img1.doubanio.com/img/celebrity/large/51737.jpg";
 medium = "https://img1.doubanio.com/img/celebrity/medium/51737.jpg";
 small = "https://img1.doubanio.com/img/celebrity/small/51737.jpg";
 };
 id = 1002676;
 name = "\U7f57\U5bbe\U00b7\U6000\U7279";
 }
 );
 "collect_count" = 3146;
 directors =             
 (
 {
 alt = "https://movie.douban.com/celebrity/1023041/";
 avatars =                     {
 large = "https://img1.doubanio.com/img/celebrity/large/55167.jpg";
 medium = "https://img1.doubanio.com/img/celebrity/medium/55167.jpg";
 small = "https://img1.doubanio.com/img/celebrity/small/55167.jpg";
 };
 id = 1023041;
 name = "\U6d3e\U8482\U00b7\U6770\U91d1\U65af";
 }
 );
 genres =             
 (
 "\U52a8\U4f5c",
 "\U5947\U5e7b",
 "\U5192\U9669"
 );
 id = 1578714;
 images =             
 {
 large = "https://img3.doubanio.com/view/movie_poster_cover/lpst/public/p2460006593.jpg";
 medium = "https://img3.doubanio.com/view/movie_poster_cover/spst/public/p2460006593.jpg";
 small = "https://img3.doubanio.com/view/movie_poster_cover/ipst/public/p2460006593.jpg";
 };
 "original_title" = "Wonder Woman";
 rating =             
 {
 average = "8.300000000000001";
 max = 10;
 min = 0;
 stars = 45;
 };
 subtype = movie;
 title = "\U795e\U5947\U5973\U4fa0";
 year = 2017;
 },*/

#import <Foundation/Foundation.h>

@class LFImageModel, LFRatingModel;
@interface LFMovieModel : NSObject

/**
 <#Description#>
 */
@property(nonatomic,strong) NSURL *alt;

@property(nonatomic,strong) NSArray<NSString *> *genres;

@property(nonatomic,strong) LFImageModel *images;

@property(nonatomic,strong) LFRatingModel *rating;

@property(nonatomic,copy) NSString *subtype;

@property(nonatomic,copy) NSString *title;

@property(nonatomic,copy) NSString *year;

@end

@interface LFImageModel : NSObject

@property(nonatomic,strong) NSURL *large;

@property(nonatomic,strong) NSURL *medium;

@property(nonatomic,strong) NSURL *small;

@end

@interface LFRatingModel : NSObject

@property(nonatomic,copy) NSString *average;

@property(nonatomic,copy) NSString *max;

@property(nonatomic,copy) NSString *min;

@property(nonatomic,copy) NSString *stars;

@end
