//
//  MHScrollLoop.h
//  MHScrollLoop
//
//  Created by ZH on 15/11/5.
//  Copyright © 2015年 M. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MHScrollLoop;

@protocol MHScrollLoopDelegate <NSObject>

@optional
-(void)scrollLoopDidSelectedImage:(MHScrollLoop *)loopView index:(int)index;


@end
@interface MHScrollLoop : UIView
@property (nonatomic,assign) id<MHScrollLoopDelegate>delegate;
// auto scroll
@property (nonatomic, assign) BOOL autoScroll;
// scroll Interval
@property (nonatomic, assign) NSTimeInterval timeInterval;
// imagesArray
@property (nonatomic, strong) NSArray *imagesArray;
/**
 *  init scroll loop
 *
 *  @param frame        frame
 *  @param images       images array
 *  @param isAuto       auto scroll
 *  @param timeInterval auto scroll Interval time
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame imagesArray:(NSArray *)imagesArray autoScroll:(BOOL)isAuto delay:(NSTimeInterval)timeInterval;

@end
