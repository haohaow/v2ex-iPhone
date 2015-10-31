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
#import "WHLaunchViewController.h"
#import "WHViewPagerHeader.h"
#import "WHTitleCatalogModel.h"
#import "WHCatalogViewController.h"
#import "UIView+Extension.h"
#import "MJExtension.h"

@interface WHHomeViewController ()
@property (nonatomic,copy) NSMutableArray *titles;
@end

@implementation WHHomeViewController
{
    WHLaunchViewController *_launchViewController;
    WHViewPagerHeader *_viewPager;
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
    
    //titleCatalog data
    NSString *titleCatalogsFile = [[NSBundle mainBundle] pathForResource:@"CatalogInfo" ofType:@"plist"];
    
    NSArray *titleCatalogs = [WHTitleCatalogModel objectArrayWithFile:titleCatalogsFile];
    //    WHLog(@"array:%@",titleCatalogs);
    
    for(WHTitleCatalogModel *titleCatalog in titleCatalogs){
        [self.titles addObject:titleCatalog];
    }
    
    self.datasource = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /** present launchViewController only once */    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _launchViewController = [[WHLaunchViewController alloc] init];
//        [self presentViewController:_launchViewController animated:NO completion:NULL];
//    });
}

#pragma mark - viewPagerDelegate

- (NSInteger)numberOfViewPagerControllers:(WHViewPagerController *)viewPagerController
{
    WHLog(@"self.titles.count:%ld",self.titles.count);
    return self.titles.count;
}

- (WHCatalogModel *)viewPagerController:(WHViewPagerController *)viewPagerController titleAtIndex:(NSInteger)index
{
    return self.titles[index];
}






@end
