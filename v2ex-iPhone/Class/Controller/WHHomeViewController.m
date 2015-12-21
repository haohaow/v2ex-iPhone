//
//  WHHomeViewController.m
//  v2ex-iPhone
//
//  Created by hhw on 15/10/20.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import "WHHomeViewController.h"
#import "WHMacros.h"
#import "WHDataManager.h"
#import "WHTitleModel.h"
#import "UIView+Extension.h"
#import "MJExtension.h"
#import "WHPagingScrollView.h"
#import "WHHomeOneVC.h"
@interface WHHomeViewController () <WHPagingScrollViewDataSource,WHPagingScrollViewDelegate>
@property (nonatomic,copy) NSMutableArray *titles;
@property (nonatomic,copy) NSMutableArray *homeVCs;
@end

@implementation WHHomeViewController
{
    WHPagingScrollView *_pagingScrollView;
}

- (NSMutableArray *)titles
{
    if(!_titles){
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (NSMutableArray *)homeVCs
{
    if(!_homeVCs){
        _homeVCs = [NSMutableArray array];
    }
    return _homeVCs;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //titleCatalog data
    NSString *titleCatalogsFile = [[NSBundle mainBundle] pathForResource:@"CatalogInfo" ofType:@"plist"];
    NSArray *titleCatalogs = [WHTitleModel objectArrayWithFile:titleCatalogsFile];

    for(WHTitleModel *titleModel in titleCatalogs){
        [self.titles addObject:titleModel.label];
        //create homeViewControllers
        WHHomeOneVC *homeVC = [[WHHomeOneVC alloc] initWithNodes:titleModel.nodes];
        [self.homeVCs addObject:homeVC];
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _pagingScrollView = [[WHPagingScrollView alloc] initWithFrame:self.view.bounds];
    _pagingScrollView.dataSource = self;
    _pagingScrollView.delegate = self;
    [self.view addSubview:_pagingScrollView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - WHPagingScrollView dataSourece
- (NSInteger)numberOfPagesInPagingScrollView:(WHPagingScrollView *)pagingScrollView
{
    return self.titles.count;
}

- (UIViewController *)pagingScrollView:(WHPagingScrollView *)pagingScrollView viewControllerAtIndex:(NSInteger)pageIndex
{
    return self.homeVCs[pageIndex];
}

@end
