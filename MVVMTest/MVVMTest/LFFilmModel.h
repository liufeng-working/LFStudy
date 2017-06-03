//
//  LFFilmModel.h
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/3.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LFImage;
@interface LFFilmModel : NSObject


////---------------rating---------------
///**
// <#Description#>
// */
//@property(nonatomic,strong) NSNumber *min;
//
///**
// <#Description#>
// */
//@property(nonatomic,strong) NSNumber *average;
//
///**
// <#Description#>
// */
//@property(nonatomic,copy) NSString *stars;
//
///**
// <#Description#>
// */
//@property(nonatomic,strong) NSNumber *max;
//
////---------------rating---------------
//
////---------------directors---------------
////---------------avatars---------------
///**
// <#Description#>
// */
//@property(nonatomic,copy) NSString *large;
//
///**
// <#Description#>
// */
//@property(nonatomic,copy) NSString *small;
//
///**
// <#Description#>
// */
//@property(nonatomic,copy) NSString *medium;
//
////---------------avatars---------------
//
///**
// <#Description#>
// */
//@property(nonatomic,copy) NSString *id;
//
///**
// <#Description#>
// */
//@property(nonatomic,copy) NSString *alt;
//
///**
// <#Description#>
// */
//@property(nonatomic,strong) NSDictionary *avatars;
//
///**
// <#Description#>
// */
//@property(nonatomic,copy) NSString *name;
//
////---------------directors---------------
//
////---------------casts---------------
////---------------avatars---------------
///**
// <#Description#>
// */
//@property(nonatomic,copy) NSString *large;
//
///**
// <#Description#>
// */
//@property(nonatomic,copy) NSString *small;
//
///**
// <#Description#>
// */
//@property(nonatomic,copy) NSString *medium;
//
////---------------avatars---------------
//
///**
// <#Description#>
// */
//@property(nonatomic,copy) NSString *id;
//
///**
// <#Description#>
// */
//@property(nonatomic,copy) NSString *alt;
//
///**
// <#Description#>
// */
//@property(nonatomic,strong) NSDictionary *avatars;
//
///**
// <#Description#>
// */
//@property(nonatomic,copy) NSString *name;
//
////---------------casts---------------

/**
 <#Description#>
 */
@property(nonatomic,copy) NSString *ID;

/**
 <#Description#>
 */
@property(nonatomic,strong) NSDictionary *rating;

/**
 <#Description#>
 */
@property(nonatomic,copy) NSString *original_title;

/**
 <#Description#>
 */
@property(nonatomic,strong) NSNumber *collect_count;

/**
 <#Description#>
 */
@property(nonatomic,strong) NSArray<NSString *> *directors;

/**
 <#Description#>
 */
@property(nonatomic,copy) NSString *title;

/**
 <#Description#>
 */
@property(nonatomic,copy) NSString *year;

/**
 <#Description#>
 */
@property(nonatomic,strong) NSArray<NSString *> *casts;

/**
 <#Description#>
 */
@property(nonatomic,strong) NSArray<NSString *> *genres;

/**
 <#Description#>
 */
@property(nonatomic,strong) LFImage *images;

/**
 <#Description#>
 */
@property(nonatomic,copy) NSString *alt;

/**
 <#Description#>
 */
@property(nonatomic,copy) NSString *subtype;

@end

@interface LFImage : NSObject

/**
 <#Description#>
 */
@property(nonatomic,copy) NSString *large;

/**
 <#Description#>
 */
@property(nonatomic,copy) NSString *small;

/**
 <#Description#>
 */
@property(nonatomic,copy) NSString *medium;

@end
