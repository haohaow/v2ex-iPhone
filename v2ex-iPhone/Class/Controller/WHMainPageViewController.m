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
#import "WHNodeModel.h"

static NSString* const kPageReuseIdentifier = @"MainPageIdentifier";

@interface WHMainPageViewController () <NIPagingScrollViewDataSource,NIPagingScrollViewDelegate,
                                        WHPagingViewDelegate,WHPaingHeaderDelegate>

@property (nonatomic,weak) WHPagingView *pageView;
@property (nonatomic,copy) NSMutableArray *topics;

@end

@implementation WHMainPageViewController
{
    NIPagingScrollView *_pagingContentView;
    WHPagingHeader *_pagingHeader;
    CGFloat _contentOffSetX;
    NSInteger _isLeft , _zeroVControl , _indicatorX;
    CGAffineTransform _indicatorTransform;
    NSMutableArray *_title,*_allNodes;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _title = [NSMutableArray array];
    _allNodes = [NSMutableArray array];
    
    _pagingContentView = [[NIPagingScrollView alloc] initWithFrame:self.view.bounds];
    _pagingContentView.dataSource = self;
    _pagingContentView.delegate = self;
    _pagingContentView.pageMargin = 0;
    _pagingContentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_pagingContentView];
    
    // iOS 7-only.
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self setupHeaderView];
    //根据头部的标题个数，contentView的个数与之相同来加载
    [_pagingContentView reloadData];

}



- (void)setupHeaderView
{
    NSString *titleCatalogsFile = [[NSBundle mainBundle] pathForResource:@"CatalogInfo" ofType:@"plist"];
    NSArray *titleCatalogs = [WHTitleModel objectArrayWithFile:titleCatalogsFile];
    
    NSMutableArray *allNodeArrs =[NSMutableArray array];
    for(WHTitleModel *titleModel in titleCatalogs){
        [_title addObject:titleModel.label];
        [allNodeArrs addObject:titleModel.nodes];
    }

    //解析每一个title下的node数组，存在_allNodes中
    for(int i=0;i<allNodeArrs.count;i++){
        NSArray *nodes =[WHNodeModel objectArrayWithKeyValuesArray:allNodeArrs[i]];
        [_allNodes addObject:nodes];
    }
    
    _pagingHeader = [[WHPagingHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    _pagingHeader.backgroundColor = nil;
    _pagingHeader.delegate = self;

    [self.view addSubview:_pagingHeader];

}

#pragma mark - NIPagingScrollViewDataSource

- (NSInteger)numberOfPagesInPagingScrollView:(NIPagingScrollView *)pagingScrollView {
    // For the sake of this example we'll show a fixed number of pages.
    return _title.count;
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

- (void)pagingScrollViewDidChangePages:(NIPagingScrollView *)pagingScrollView
{
    NSInteger index = pagingScrollView.centerPageIndex;
    [self titleView:_pagingHeader.titleViews[index] moveToTitleAtIndex:index animated:YES];
    
    _indicatorX = _pagingHeader.indicator.x;
}

#pragma mark - WHPagingView dataSource & delegate


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    CGPoint v = [scrollView.panGestureRecognizer velocityInView:scrollView];
    
    if(v.x < 0){
        _isLeft = YES;
        _zeroVControl = YES;
    }else if(v.x > 0){
        _isLeft = NO;
        _zeroVControl = NO;
    }else{
        _isLeft = _zeroVControl;
    }
    _indicatorTransform = _pagingHeader.indicator.transform;
    _contentOffSetX = scrollView.contentOffset.x;
    _indicatorX = _pagingHeader.indicator.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat transX;
    UIButton* nextBtn,*currentBtn;

    CGFloat percent = (fabs(scrollView.contentOffset.x - _contentOffSetX)/scrollView.width);
    
    NSInteger pageIndex = _pagingContentView.centerPageIndex;

    if(_isLeft && [_pagingContentView hasNext]){
        if(pageIndex == _pagingHeader.titleViews.count){
            nextBtn = _pagingHeader.titleViews[pageIndex];
            currentBtn = nextBtn;
        }else{
            nextBtn = _pagingHeader.titleViews[pageIndex+1];
            currentBtn = _pagingHeader.titleViews[pageIndex];
        }
        _pagingHeader.indicator.x = _indicatorX + (nextBtn.x -currentBtn.x) * percent;
    }else{
        if (pageIndex <= 0) {
            pageIndex = 0;
            nextBtn = _pagingHeader.titleViews[pageIndex];
            currentBtn = nextBtn;
        }else{
            nextBtn = _pagingHeader.titleViews[pageIndex - 1];
            currentBtn = _pagingHeader.titleViews[pageIndex];
        }
        _pagingHeader.indicator.x = _indicatorX + (nextBtn.x -currentBtn.x) * percent ;
    }

    transX = ((nextBtn.width- currentBtn.width) / currentBtn.width) * percent;
    _pagingHeader.indicator.transform = CGAffineTransformScale(_indicatorTransform, transX + 1, 1);
    
}

- (NSInteger)pagingView:(id)pagingView numberOfSectionsInPage:(NSInteger)pageNumber
{
    return 1;
}

- (NSInteger)pagingView:(id)pagingView numberOfRowsInPage:(NSInteger)page section:(NSInteger)section
{
    NSArray *nodesByPage = [_allNodes objectAtIndex:page];
    return nodesByPage.count;
}

- (UITableViewCell *)pagingView:(WHPagingView *)pagingView cellForRowAtIndexPath:(NSIndexPath *)indexPath pagingIndex:(NSInteger)page
{

    static NSString *identity = @"UITableViewCell";

    UITableViewCell *cell = [pagingView.tableView dequeueReusableCellWithIdentifier:identity];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identity];
    }

    NSArray *nodesByPage = [_allNodes objectAtIndex:page];

        WHNodeModel *node = (WHNodeModel *)nodesByPage[indexPath.row];

        [[cell textLabel] setText:[NSString stringWithFormat:@"%@,%@",node.name,node.name]];

    
    

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
    return _title.count;
}

- (NSString *)pagingHeader:(WHPagingHeader *)pagingHeader titleViewAtIndex:(NSInteger)index
{
    return _title[index];
}

- (void)titleView:(UIView *)titleView clickIndex:(NSInteger)index animated:(BOOL)animated
{

    if(index!=_pagingContentView.centerPageIndex){
        _indicatorTransform = _pagingHeader.indicator.transform;
        [self titleView:titleView moveToTitleAtIndex:index animated:YES];
        [_pagingContentView moveToPageAtIndex:index animated:NO];

    }
    
}

#pragma mark - private method

- (void)titleView:(UIView *)titleView moveToTitleAtIndex:(NSInteger)index animated:(BOOL)animated
{
    CGFloat offsetX;
    
    UIButton* titleBtn = (UIButton*)titleView;
    
    CGFloat availableOffsetX = _pagingHeader.headerScrollView.contentSize.width - _pagingHeader.headerScrollView.width;
    
    offsetX = titleBtn.centerX - kScreenWidth/2;
    
    if(offsetX > availableOffsetX){
        offsetX = availableOffsetX;
    }else if (offsetX < 0.0){
        offsetX = 0.0;
    }
    
    [_pagingHeader.headerScrollView setContentOffset:CGPointMake(offsetX,0) animated:animated];
    
    _pagingHeader.indicator.width = titleBtn.width;
    _pagingHeader.indicator.centerX = titleBtn.centerX;
    
    titleBtn.selected = YES;

}



@end
