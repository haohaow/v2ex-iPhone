//
//  WHViewPagerController.h
//  v2ex-iPhone
//
//  Created by hhw on 15/10/23.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHViewPagerHeader.h"

@class WHViewPagerController;
@protocol WHViewPagerDelegate <NSObject>

@end

@protocol WHViewPagerDataSource <NSObject>

- (NSArray *)titlesInViewPagerHeader:(WHViewPagerController *)viewPagerController;

@end

@interface WHViewPagerController : UIViewController <UIScrollViewDelegate>

@property (nonatomic,weak) id<WHViewPagerDelegate> delegate;
@property (nonatomic,weak) id<WHViewPagerDataSource> dataSource;

//标题item根据文字长度sizeTofit 文字改变按钮宽度也会变化
- (void)reloadData;

@end


