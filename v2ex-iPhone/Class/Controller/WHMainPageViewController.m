//
//  WHMainPageViewController.m
//  v2ex-iPhone
//
//  Created by hhw on 15/11/3.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import "WHMainPageViewController.h"
#import "NIPagingScrollView.h"
#import "WHPagingView.h"
#import "WHMacros.h"
#import "WHTitleModel.h"
#import "MJExtension.h"
#import "WHPagingHeader.h"
#import "UIView+Extension.h"

static NSString* const kPageReuseIdentifier = @"MainPageIdentifier";

@interface WHMainPageViewController () <NIPagingScrollViewDataSource,WHPagingViewDelegate,WHPaingHeaderDelegate>
@property (nonatomic,strong) NSMutableArray *titles;
@end

@implementation WHMainPageViewController
{
    NIPagingScrollView *_pagingScrollView;
    WHPagingHeader *_pagingHeader;
    CGFloat _headerOffSetX;
}

- (NSMutableArray *)titles
{
    if(!_titles){
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _pagingScrollView = [[NIPagingScrollView alloc] initWithFrame:self.view.bounds];
    _pagingScrollView.dataSource = self;
    _pagingScrollView.pageMargin = 0;
    _pagingScrollView.backgroundColor = WHRandomColor;
    [self.view addSubview:_pagingScrollView];
    
    // iOS 7-only.
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [_pagingScrollView reloadData];
    
    [self setupHeaderView];

}

- (void)setupHeaderView
{
    NSString *titleCatalogsFile = [[NSBundle mainBundle] pathForResource:@"CatalogInfo" ofType:@"plist"];
    NSArray *titleCatalogs = [WHTitleModel objectArrayWithFile:titleCatalogsFile];

    for(WHTitleModel *titleModel in titleCatalogs){
        [self.titles addObject:titleModel.label];
    }
    _pagingHeader = [[WHPagingHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    _pagingHeader.backgroundColor = nil;
    _pagingHeader.delegate = self;
    [self.view addSubview:_pagingHeader];
    

}

#pragma mark - NIPagingScrollViewDataSource

- (NSInteger)numberOfPagesInPagingScrollView:(NIPagingScrollView *)pagingScrollView {
    // For the sake of this example we'll show a fixed number of pages.
    return 10;
}

// Similar to UITableViewDataSource, we create each page view on demand as the user is scrolling
// through the page view.
// Unlike UITableViewDataSource, this method requests a UIView that conforms to a protocol, rather
// than requiring a specific subclass of a type of view. This allows you to use any UIView as long
// as it conforms to NIPagingScrollView.
- (UIView<NIPagingScrollViewPage> *)pagingScrollView:(NIPagingScrollView *)pagingScrollView pageViewForIndex:(NSInteger)pageIndex {
    // Check the reusable page queue.
    WHPagingView *page = (WHPagingView *)[pagingScrollView dequeueReusablePageWithIdentifier:kPageReuseIdentifier];
    // If no page was in the reusable queue, we need to create one.
    if (nil == page) {
        page = [[WHPagingView alloc] initWithReuseIdentifier:kPageReuseIdentifier];
    }
    page.delegate = self;
    return page;
}

#pragma mark - UITableView dataSource & delegate

- (NSInteger)pagingView:(id)pagingView numberOfSectionsInPage:(NSInteger)pageNumber
{
    return 1;
}

- (NSInteger)pagingView:(id)pagingView numberOfRowsInPage:(NSInteger)page section:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)pagingView:(WHPagingView *)pagingView cellForRowAtIndexPath:(NSIndexPath *)indexPath pagingIndex:(NSInteger)index
{

    static NSString *identity = @"UITableViewCell";

    UITableViewCell *cell = [pagingView.tableView dequeueReusableCellWithIdentifier:identity];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identity];
    }
    [[cell textLabel] setText:[NSString stringWithFormat:@"panel %zi section %ld row %ld", index, indexPath.section, indexPath.row+1]];

    return cell;
}

- (CGFloat)pagingView:(id)pagingView heightForRowAtIndexPath:(NSIndexPath *)indexPath pagingIndex:(NSInteger)index
{
    return 50;
}

- (void)pagingView:(id)pagingView didSelectRowAtIndexPath:(NSIndexPath *)indexPath pagingIndex:(NSInteger)index
{
    WHLog(@"didSelectRowAtIndexPath");
}

#pragma mark - WHPagingHeaderDelegate

- (NSInteger)numbersOfTitleInHeader:(WHPagingHeader *)pagingHeader
{
    return self.titles.count;
}

- (NSString *)pagingHeader:(WHPagingHeader *)pagingHeader titleViewAtIndex:(NSInteger)index
{
    return self.titles[index];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _headerOffSetX = scrollView.contentOffset.x;
}

- (void)titleView:(UIView *)titleView clickIndex:(NSInteger)index animated:(BOOL)animated
{
    CGFloat offsetX;
//    UIButton *currentBtn = (UIButton*)_pagingHeader.titleViews[_pagingScrollView.centerPageIndex];
//    if(_pagingHeader.headerScrollView.contentOffset.x==0 && currentBtn.centerX<kScreenWidth/2){
//        offSetX = (titleView.centerX - kScreenWidth/2);
//    }
    UIButton* titleBtn = (UIButton*)titleView;
    
    CGFloat availableOffsetX = _pagingHeader.headerScrollView.contentSize.width - _pagingHeader.headerScrollView.width;
   
    
    offsetX = titleBtn.centerX - kScreenWidth/2;
    if(offsetX > availableOffsetX){
        offsetX = availableOffsetX;
    }else if (offsetX < 0.0){
        offsetX = 0.0;
    }
    [_pagingHeader.headerScrollView setContentOffset:CGPointMake(offsetX,0) animated:YES];
    titleBtn.selected = YES;
    WHLog(@"clickIndex:%ld,numberOfPages:%ld,centerPageIndex:%ld",index,_pagingScrollView.numberOfPages,_pagingScrollView.centerPageIndex);
    [_pagingScrollView moveToPageAtIndex:index animated:NO];

}

- (void)moveOffSet
{
//    NSInteger startOffsetIndex = (_pagingHeader.width / titleView.width) / 2.0;
//    if(index < startOffsetIndex){
//        index = startOffsetIndex;
//    }else if (index == _pagingHeader.titleViews.count - 1){
//        index = _pagingHeader.titleViews.count - startOffsetIndex;
//    }
//    CGFloat offsetX = (index - startOffsetIndex) * titleView.width;
//    [_pagingHeader.headerScrollView setContentOffset:CGPointMake(offsetX, 0)];
//    WHLog(@"startOffsetIndex:%ld,_pagingHeader.width:%f,titleView.width:%f",startOffsetIndex,_pagingHeader.width,titleView.width);
}





@end
