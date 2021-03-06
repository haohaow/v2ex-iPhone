//
//  WHViewPager.m
//  v2ex-iPhone
//
//  Created by hhw on 15/10/22.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import "WHPagingHeader.h"
#import "UIView+Extension.h"
#import "WHMacros.h"
#import "WHTitleModel.h"

#define TitleTag 11000
#define IndicatorHeigh 2;
#define TitleMargin 15
@implementation WHPagingHeader
{
    NSInteger _numberOfPages;
}

- (NSMutableArray*)titleViews
{
    if(!_titleViews){
        _titleViews = [NSMutableArray array];
    }
    return _titleViews;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self commitInit];
    }
    return self;
}

- (void)commitInit
{
    _headerScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _headerScrollView.pagingEnabled = YES;
    _headerScrollView.scrollsToTop = NO;
    // Allows the scroll view to show adjacent pages...
    _headerScrollView.clipsToBounds = NO;
    // ...while still clipping contents to the bounds of the paging scroll view.
    self.clipsToBounds = YES;
    
    _headerScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _headerScrollView.showsVerticalScrollIndicator = NO;
    _headerScrollView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:_headerScrollView];
    
    _indicator = [[UIImageView alloc] init];
    _indicator.backgroundColor = WHRandomColor;
    [_headerScrollView addSubview:_indicator];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _numberOfPages = [self.delegate numbersOfTitleInHeader:self];
    
    for(int i=0;i<_numberOfPages;i++){
        
        UIView *titleView = [self titleViewAtIndex:i];
        titleView.frame = [self frameAtIndex:i];
        [_headerScrollView addSubview:titleView];
    }
    
    _headerScrollView.contentSize = [self contentSizeForPagingScrollView];
    
    _indicator.frame = [self indicatorFrameAtIndex:0];
    
}

- (CGRect)frameAtIndex:(NSInteger)index
{
    if(index > 0){
        UIView *preTitleView = (UIView*)self.titleViews[index - 1];
        UIView *titleView = (UIView*)self.titleViews[index];
        CGRect frame = CGRectMake(CGRectGetMaxX(preTitleView.frame)+TitleMargin, 0, titleView.width, 44) ;
        return frame;
    }else{
        UIView *titleView = (UIView*)self.titleViews[index];
        CGRect frame = CGRectMake(TitleMargin, 0, titleView.width, 44);
        return frame;
    }
}

- (CGRect)indicatorFrameAtIndex:(NSInteger)index
{
    CGRect frame = [self frameAtIndex:index];
    frame.size.height = IndicatorHeigh;
    frame.origin.y = _headerScrollView.height - IndicatorHeigh;
    return frame;
}

- (UIView *)titleViewAtIndex:(NSInteger)index
{
    NSString *title = [self.delegate pagingHeader:self titleViewAtIndex:index];
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleButton setTitle:title forState:UIControlStateNormal];
    titleButton.backgroundColor = nil;
    titleButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [titleButton sizeToFit];
    titleButton.tag = TitleTag+index;

    [titleButton addTarget:self action:@selector(clickTitleView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.titleViews addObject:titleButton];
    return titleButton;
}

- (CGSize)contentSizeForPagingScrollView
{
    return CGSizeMake( CGRectGetMaxX(((UIView *)self.titleViews.lastObject).frame), 0);
}

- (void)clickTitleView:(id)sender
{
    if(_delegate && [_delegate respondsToSelector:@selector(titleView:clickIndex: animated:)]){
        [_delegate titleView:sender clickIndex:((UIButton*)sender).tag-TitleTag animated:YES];
    }
}








@end
