//
//  WHViewPager.m
//  v2ex-iPhone
//
//  Created by hhw on 15/10/22.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import "WHViewPager.h"
#import "UIView+Extension.h"
#import "WHMacros.h"
#import "WHTitleCatalogModel.h"

static const CGFloat titleFontSie = 14;
@implementation WHViewPager

- (NSMutableArray *)titles
{
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (instancetype)initWithTitleCount:(NSInteger)titleCount
{
    self = [super init];
    if(self){
        UIButton *buttonPre;
        for(int i=0;i<titleCount;i++){
            UIButton *titleButton = [self titleButton];
            [self addSubview:titleButton];
            [self.titles addObject:titleButton];
            buttonPre = titleButton;
        }
        self.frame = CGRectMake(0, 64, kScreenWidth, buttonPre.height);
        self.scrollEnabled = YES;
        self.alwaysBounceVertical = NO;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor whiteColor];
        
        WHViewPageIndicator *pageIndicator = [[WHViewPageIndicator alloc] initWithFrame:CGRectMake(0, 0, 50, 2)];
        [self addSubview:pageIndicator];
        self.pageIndicator = pageIndicator;
        
    }
    return self;
}

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

- (UIButton *)titleButtonWithTitle:(NSString *)title titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:titleFontSie];
    button.contentEdgeInsets = titleEdgeInsets;
    [button sizeToFit];
    return button;
}

- (UIButton *)titleButton
{
    return [self titleButtonWithTitle:@"" titleEdgeInsets:UIEdgeInsetsMake(10, 10, 15, 10)];
}

#pragma mark - public method

- (UIButton *)titleButtonWithTitle:(WHCatalogModel *)title titleAtIndex:(NSInteger)index
{
    UIButton *button = (UIButton *)self.titles[index];
    [button setTitle:title.label forState:UIControlStateNormal];
    [button setTitleColor:WHColor(119, 128, 135) forState:UIControlStateNormal];
    [button setTitleColor:WHColor(104, 104, 104) forState:UIControlStateHighlighted];
//    button.backgroundColor = WHRandomColor;
    [button sizeToFit];
    if(index == 0){
        button.x = 0;
    }else {
        UIButton *buttonPre = (UIButton *)self.titles[index - 1];
        button.x = CGRectGetMaxX(buttonPre.frame);
    }
    return button;
}


@end
