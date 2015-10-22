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
#import "WHViewPageIndicator.h"

static const CGFloat titleFontSie = 14;

@implementation WHViewPager

- (instancetype)initWithCatalogs:(NSArray *)catalogs
{
    self = [super init];
    if(self){
        UIButton *buttonPre ;
        for(int i=0;i<catalogs.count;i++){
            UIEdgeInsets edgeInsets = UIEdgeInsetsMake(10, 10, 15, 10);
            UIButton *catalogButton = [self buttonWithCatalogLabel:catalogs[i] titleEdgeInsets:edgeInsets];
            catalogButton.x = CGRectGetMaxX(buttonPre.frame);
            [self addSubview:catalogButton];
            buttonPre = catalogButton;
        }
        self.scrollEnabled = YES;
        self.alwaysBounceVertical = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.contentSize = CGSizeMake(CGRectGetMaxX(buttonPre.frame), buttonPre.height);
        self.frame = CGRectMake(0, 64, kScreenWidth, buttonPre.height + 100);
        self.backgroundColor = WHRandomColor;
        
        WHViewPageIndicator *indicator = [[WHViewPageIndicator alloc] initWithFrame:CGRectMake(0, 0, 50, 2)];
        [self addSubview:indicator];
    }
    return self;
}

- (UIButton *)buttonWithCatalogLabel:(NSString *)catalogLabel titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.backgroundColor = WHRandomColor;
    [button setTitle:catalogLabel forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:titleFontSie];
//    [button sizeToFit];
    button.contentEdgeInsets = titleEdgeInsets;
    [button sizeToFit];
    return button;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
