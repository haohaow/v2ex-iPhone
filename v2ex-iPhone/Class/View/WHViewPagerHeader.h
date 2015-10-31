//
//  WHViewPager.h
//  v2ex-iPhone
//
//  Created by hhw on 15/10/22.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WHViewPagerHeader;
@protocol WHViewPagerHeaderDelegate <NSObject>

@end

@protocol WHViewPagerHeaderDataSouce <NSObject>
@required
- (void)numberOfTitles:(WHViewPagerHeader *)viewPagerHeader;

@end

@interface WHViewPagerHeader : UIScrollView

@property (nonatomic,weak) id<WHViewPagerHeaderDataSouce> dataSource;

@end

