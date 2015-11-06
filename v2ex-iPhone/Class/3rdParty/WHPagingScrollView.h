//
//  WHPagingScrollView.h
//  v2ex-iPhone
//
//  Created by hhw on 15/11/3.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WHPagingScrollViewDataSource;
@protocol WHPagingScrollViewDelegate;

@interface WHPagingScrollView : UIView
@property (nonatomic,weak) id<WHPagingScrollViewDataSource> dataSource;
@property (nonatomic,weak) id<WHPagingScrollViewDelegate> delegate;

@property (nonatomic, readonly) NSInteger numberOfPages;

- (void)reloadData;
@end

@protocol WHPagingScrollViewDataSource <NSObject>

@required
- (NSInteger)numberOfPagesInPagingScrollView:(WHPagingScrollView *)pagingScrollView;
- (UIViewController *)pagingScrollView:(WHPagingScrollView *)pagingScrollView viewControllerAtIndex:(NSInteger)pageIndex;

@end

@protocol WHPagingScrollViewDelegate <NSObject>

@end