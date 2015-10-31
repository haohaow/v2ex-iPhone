//
//  WHViewPager.m
//  v2ex-iPhone
//
//  Created by hhw on 15/10/22.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import "WHViewPagerHeader.h"
#import "UIView+Extension.h"
#import "WHMacros.h"
#import "WHTitleCatalogModel.h"
//头部初始字体
static const CGFloat titleFontSize = 14;

@implementation WHViewPagerHeader
{
    NSMutableArray *_titles;
    UIImageView *_indicator;
}

- (void)setDataSource:(id<WHViewPagerHeaderDataSouce>)dataSource
{
    _dataSource = dataSource;
    [self reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        WHLog(@"initWithFrame");
    }
    return self;
}

- (UIButton *)setupItemWithTitle:(NSString *)title
{
    UIButton *headerItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [headerItem setTitle:title forState:UIControlStateApplication];
    [headerItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    headerItem.titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
    [headerItem sizeToFit];
    return headerItem;
}

- (void)reloadData
{
    
}

//- (NSMutableArray *)titles
//{
//    if (!_titles) {
//        _titles = [NSMutableArray array];
//    }
//    return _titles;
//}
//
//- (instancetype)initWithTitleCount:(NSInteger)titleCount
//{
//    self = [super init];
//    if(self){
//        UIButton *buttonPre;
//        for(int i=0;i<titleCount;i++){
//            UIButton *titleButton = [self titleButton];
//            [self addSubview:titleButton];
//            [self.titles addObject:titleButton];
//            buttonPre = titleButton;
//        }
//        self.frame = CGRectMake(0, 64, kScreenWidth, buttonPre.height);
//        self.scrollEnabled = YES;
//        self.alwaysBounceVertical = NO;
//        self.bounces = NO;
//        self.showsHorizontalScrollIndicator = NO;
//        self.backgroundColor = [UIColor whiteColor];
//        
//        
//    }
//    return self;
//}
//
//- (instancetype)initWithTitles:(NSArray *)titles
//{
//    self = [super init];
//    if(self){
//        UIButton *buttonPre ;
//        for(int i=0;i<titles.count;i++){
//            UIEdgeInsets edgeInsets = UIEdgeInsetsMake(10, 10, 15, 10);
//            UIButton *titleButton = [self buttonWithTitle:titles[i] titleEdgeInsets:edgeInsets];
//            titleButton.x = CGRectGetMaxX(buttonPre.frame);
//            [self addSubview:titleButton];
//            buttonPre = titleButton;
//        }
//        self.scrollEnabled = YES;
//        self.alwaysBounceVertical = NO;
//        self.showsHorizontalScrollIndicator = NO;
//        self.contentSize = CGSizeMake(CGRectGetMaxX(buttonPre.frame), buttonPre.height);
//        self.frame = CGRectMake(0, 64, kScreenWidth, buttonPre.height + 100);
//        self.backgroundColor = WHRandomColor;
//        
//        WHViewPageIndicator *indicator = [[WHViewPageIndicator alloc] initWithFrame:CGRectMake(0, 0, 50, 2)];
//        [self addSubview:indicator];
//        
//        for(int i=0;i<){
//        
//        }
//    }
//    return self;
//}
#pragma mark - private method

//- (UIButton *)titleButtonWithTitle:(NSString *)title titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets
//{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:title forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:titleFontSie];
//    button.contentEdgeInsets = titleEdgeInsets;
//    [button sizeToFit];
//    return button;
//}
//
//- (UIButton *)titleButton
//{
//    return [self titleButtonWithTitle:@"" titleEdgeInsets:UIEdgeInsetsMake(10, 10, 15, 10)];
//}
//
//#pragma mark - public method
//
//- (UIButton *)titleButtonWithTitle:(WHCatalogModel *)title titleAtIndex:(NSInteger)index
//{
//    UIButton *button = (UIButton *)self.titles[index];
//    [button setTitle:title.label forState:UIControlStateNormal];
//    [button setTitleColor:WHColor(119, 128, 135) forState:UIControlStateNormal];
//    [button setTitleColor:WHColor(104, 104, 104) forState:UIControlStateHighlighted];
////    button.backgroundColor = WHRandomColor;
//    [button sizeToFit];
//    if(index == 0){
//        button.x = 0;
//    }else {
//        UIButton *buttonPre = (UIButton *)self.titles[index - 1];
//        button.x = CGRectGetMaxX(buttonPre.frame);
//    }
//    return button;
//}
//
//- (void)setPageIndicatorSize:(CGSize)size
//{
//    self.pageIndicator.size = size;
//}


@end
