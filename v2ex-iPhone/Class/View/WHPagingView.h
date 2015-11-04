//
//  WHMainPageView.h
//  v2ex-iPhone
//
//  Created by hhw on 15/11/3.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NimbusPagingScrollView.h"

@protocol WHPagingViewDelegate <NSObject>
- (NSInteger)pagingView:(id)pagingView numberOfRowsInPage:(NSInteger)page section:(NSInteger)section;
- (UITableViewCell *)pagingView:(id)pagingView cellForRowAtIndexPath:(NSIndexPath *)indexPath pagingIndex:(NSInteger)index;
- (void)pagingView:(id)pagingView didSelectRowAtIndexPath:(NSIndexPath *)indexPath pagingIndex:(NSInteger)index;
- (CGFloat)pagingView:(id)pagingView heightForRowAtIndexPath:(NSIndexPath *)indexPath pagingIndex:(NSInteger)index;
- (NSInteger)pagingView:(id)pagingView numberOfSectionsInPage:(NSInteger)pageNumber;
@end

@interface WHPagingView : UIView <NIPagingScrollViewPage,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,weak) id<WHPagingViewDelegate> delegate;
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
