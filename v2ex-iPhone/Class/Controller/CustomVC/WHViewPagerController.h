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

@required

- (NSInteger)numberOfViewPagerControllers:(WHViewPagerController *)viewPagerController;
- (WHCatalogModel *)viewPagerController:(WHViewPagerController *)viewPagerController titleAtIndex:(NSInteger)index;

@end

@interface WHViewPagerController : UIViewController <UIScrollViewDelegate>

@property (nonatomic,weak) id<WHViewPagerDelegate> delegate;
@property (nonatomic,weak) id<WHViewPagerDataSource> datasource;

- (void)reload;

@end


