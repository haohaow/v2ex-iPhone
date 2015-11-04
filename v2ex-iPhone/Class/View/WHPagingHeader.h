//
//  WHViewPager.h
//  v2ex-iPhone
//
//  Created by hhw on 15/10/22.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WHPaingHeaderDelegate;

@interface WHPagingHeader : UIView
@property (nonatomic,copy) NSMutableArray *titleViews;
@property (nonatomic,strong) UIScrollView *headerScrollView;
@property (nonatomic,weak) id<WHPaingHeaderDelegate> delegate;
@end

@protocol WHPaingHeaderDelegate <NSObject,UIScrollViewDelegate>
@required
- (NSInteger)numbersOfTitleInHeader:(WHPagingHeader *)pagingHeader;
- (NSString *)pagingHeader:(WHPagingHeader *)pagingHeader titleViewAtIndex:(NSInteger)index;
- (void)titleView:(UIView *)titleView clickIndex:(NSInteger)index animated:(BOOL)animated;
@end
