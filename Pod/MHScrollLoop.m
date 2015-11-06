//
//  MHScrollLoop.m
//  MHScrollLoop
//
//  Created by ZH on 15/11/5.
//  Copyright © 2015年 M. All rights reserved.
//
#define kPageH 20
#import "MHScrollLoop.h"
@interface MHScrollLoop ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *currentImagesArray;
@property (nonatomic, assign) int currentPage;

@property (nonatomic, strong) UIView *pageControlBgView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;

@end
@implementation MHScrollLoop

-(instancetype)initWithFrame:(CGRect)frame imagesArray:(NSArray *)imagesArray autoScroll:(BOOL)isAuto delay:(NSTimeInterval)timeInterval
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _autoScroll = isAuto;
        _timeInterval = timeInterval;
        _imagesArray = imagesArray;
        _currentPage = 0;
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControlBgView];
//        run loop
        if (isAuto)
        {
            [self autoScrollLoop];
        }
    }
    return self;
}
- (void)refreshImages
{
    NSArray *subViews = self.scrollView.subviews;
    for (int i = 0; i < subViews.count; i++)
    {
        UIImageView *imageView = (UIImageView *)subViews[i];
        imageView.image = [UIImage imageNamed:self.currentImagesArray[i]];
    }
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
}

#pragma mark -- delegate
-(void)handleSingleFingerEvent:(UITapGestureRecognizer *)recognizer
{
    if ([self.delegate respondsToSelector:@selector(scrollLoopDidSelectedImage:index:)])
    {
        [self.delegate scrollLoopDidSelectedImage:self index:_currentPage];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;
    CGFloat width = self.frame.size.width;
    if (x >= 2 * width)
    {
        _currentPage = (++ _currentPage) % self.imagesArray.count;
        self.pageControl.currentPage = _currentPage;
        [self refreshImages];
    }
    if (x <= 0)
    {
        _currentPage = (int)(_currentPage + self.imagesArray.count - 1) % self.imagesArray.count;
        self.pageControl.currentPage = _currentPage;
        [self refreshImages];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:YES];
}
#pragma mark -- auto scroll
-(void)autoScrollLoop
{
    [self performSelector:@selector(autoScrollToNextPage) withObject:nil afterDelay:_timeInterval];
}
-(void)autoScrollToNextPage
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoScrollLoop) object:nil];
    [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width * 2, 0) animated:YES];
    [self performSelector:@selector(autoScrollToNextPage) withObject:nil afterDelay:_timeInterval];
}

-(NSMutableArray *)currentImagesArray
{
    if (! _currentImagesArray)
    {
        _currentImagesArray = [NSMutableArray array];
    }
    [_currentImagesArray removeAllObjects];
    NSInteger count = self.imagesArray.count;
    int i = (int)(_currentPage + count - 1) % count;
    [_currentImagesArray addObject:self.imagesArray[i]];
    [_currentImagesArray addObject:self.imagesArray[_currentPage]];
    i = (int)(_currentPage + 1) % count;
    [_currentImagesArray addObject:self.imagesArray[i]];
    return _currentImagesArray;
}



#pragma mark -- initViews

-(UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = ({
            UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:({
                CGRect frame = self.bounds;
                frame;
            })];
            scroll;
        });
        CGFloat width = self.bounds.size.width;
        CGFloat height = self.bounds.size.height;
        for (int i = 0; i < 3; i ++)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
            imageView.image = [UIImage imageNamed:self.currentImagesArray[i]];
            [_scrollView addSubview:imageView];
        }
//        设置scrollview 的大小
        _scrollView.contentSize = CGSizeMake(3 * width, height);
//        scrolview 偏移量
        _scrollView.contentOffset = CGPointMake(width, 0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
//        添加单击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
        [_scrollView addGestureRecognizer:tap];
    }
    return _scrollView;
}
-(UIPageControl *)pageControl
{
    if (!_pageControl)
    {
        _pageControl = ({
            UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:({
                CGRect frame = CGRectMake(0, 0, self.bounds.size.width, kPageH);
                frame;
            })];
            pageControl;
        });
        _pageControl.numberOfPages = self.imagesArray.count;
        _pageControl.currentPage = 0;
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}
-(UIView *)pageControlBgView
{
    if (!_pageControlBgView)
    {
        _pageControlBgView = ({
            UIView *bgView = [[UIView alloc] initWithFrame:({
                CGRect frame = CGRectMake(0, self.bounds.size.height - kPageH, self.bounds.size.width, kPageH);
                frame;
            })];
            bgView;
        });
        _pageControlBgView.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.2];
        [_pageControlBgView addSubview:self.pageControl];
    }
    return _pageControlBgView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
