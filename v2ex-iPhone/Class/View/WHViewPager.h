//
//  WHViewPager.h
//  v2ex-iPhone
//
//  Created by hhw on 15/10/22.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHViewPageIndicator.h"

@class WHCatalogModel,WHViewPageIndicator;
@interface WHViewPager : UIScrollView

@property (nonatomic,copy) NSMutableArray *titles;
@property (nonatomic,weak) WHViewPageIndicator *pageIndicator;

//- (instancetype)initWithTitles:(NSArray *)titles;
- (instancetype)initWithTitleCount:(NSInteger)titleCount;
- (UIButton *)titleButtonWithTitle:(WHCatalogModel *)title titleAtIndex:(NSInteger)index;

@end
