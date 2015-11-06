//
//  WHPagingScrollView.m
//  v2ex-iPhone
//
//  Created by hhw on 15/11/3.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import "WHPagingScrollView.h"
#import "WHMacros.h"

@implementation WHPagingScrollView
{
    UIScrollView *_scrollView;
    NSMutableArray *_visiblePages;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInit];
   }
    return self;
}

- (void)commonInit
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollsToTop = NO;
    // Allows the scroll view to show adjacent pages...
    _scrollView.clipsToBounds = NO;
    // ...while still clipping contents to the bounds of the paging scroll view.
    self.clipsToBounds = YES;
    
//    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:_scrollView];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    WHLog(@"pagingScrollView layoutSubviews");
    _numberOfPages = [self.dataSource numberOfPagesInPagingScrollView:self];
    for(int pageIndex=0;pageIndex<_numberOfPages;pageIndex++){
        
        UIViewController* oneVc = [self.dataSource pagingScrollView:self viewControllerAtIndex:pageIndex];
        oneVc.view.frame = [self frameForPageAtIndex:pageIndex];
        [_scrollView addSubview:oneVc.view];
        
        [_visiblePages addObject:oneVc];
        
    }
    
    _scrollView.contentSize = [self contentSizeForPagingScrollView];
    
}

#pragma mark - private 
-  (CGSize)contentSizeForPagingScrollView
{
    CGRect bounds = _scrollView.bounds;
    return CGSizeMake(bounds.size.width * _numberOfPages, bounds.size.height);
}

- (CGRect)frameForPageAtIndex:(NSInteger)pageIndex
{
    CGRect bounds = _scrollView.bounds;
    CGRect pageFrame = bounds;
    pageFrame.origin.x = (bounds.size.width * pageIndex);
    return pageFrame;
}

- (void)setDataSource:(id<WHPagingScrollViewDataSource>)dataSource
{
    _dataSource = dataSource;
    [self reloadData];
}

#pragma mark - public
- (void)reloadData
{
    _visiblePages = [NSMutableArray array];
    
    _scrollView.contentSize = [self contentSizeForPagingScrollView];
}








































@end
