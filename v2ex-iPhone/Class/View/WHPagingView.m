//
//  WHMainPageView.m
//  v2ex-iPhone
//
//  Created by hhw on 15/11/3.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import "WHPagingView.h"
#import "WHMacros.h"

@implementation WHPagingView

@synthesize pageIndex = _pageIndex;
@synthesize reuseIdentifier = _reuseIdentifier;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithFrame:CGRectZero])) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        [self addSubview:_tableView];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setScrollsToTop:NO];

        self.reuseIdentifier = reuseIdentifier;
    }
    
    return self;
}

- (void)setPageIndex:(NSInteger)pageIndex
{
    _pageIndex = pageIndex;
    _tableView.frame = CGRectMake(0, 44, kScreenWidth, kScreenHeight - 49 - 64 - 44);
}

- (void)setDelegate:(id<WHPagingViewDelegate>)delegate
{
    _delegate = delegate;
    [_tableView reloadData];
}

#pragma mark tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([self.delegate respondsToSelector:@selector(pagingView:numberOfSectionsInPage:)]){
        return [self.delegate pagingView:self numberOfSectionsInPage:self.pageIndex];
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(pagingView:numberOfRowsInPage:section:)])
    {
        return [self.delegate pagingView:self numberOfRowsInPage:self.pageIndex section:section];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(pagingView:cellForRowAtIndexPath:pagingIndex:)]){
        return [self.delegate pagingView:self cellForRowAtIndexPath:indexPath pagingIndex:self.pageIndex];
    }
    return nil;
}

- (CGFloat)pagingView:(id)pagingView heightForRowAtIndexPath:(NSIndexPath *)indexPath pagingIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(pagingView:heightForRowAtIndexPath:pagingIndex:)])
    {
        return [self.delegate pagingView:self heightForRowAtIndexPath:indexPath pagingIndex:index];
    }
    else return 0;

}
@end
