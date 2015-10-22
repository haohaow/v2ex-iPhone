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
#import "WHViewPager.h"
#import "WHCatalogModel.h"
#import "WHCatalogViewController.h"
#import "UIView+Extension.h"

@implementation WHHomeViewController
{
    WHLaunchViewController *_launchViewController;
    WHViewPager *_viewPager;
    NSDictionary *_titleCatalogs;
}

- (instancetype)initWithTitleCatalogs:(NSDictionary *)titleCatalogs
{
    self = [super init];
    if(self){
        _titleCatalogs = titleCatalogs;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [[WHDataManager sharedManager] catalogSuccess:^(NSArray *result) {
        WHLog(@"成功：%@",result);
        NSMutableArray *titles = [NSMutableArray array];
        for(WHCatalogModel *catalog in result){
            NSString *catalogLabel = catalog.catalogLabel;
            [titles addObject:catalogLabel];
        }
        
        _viewPager = [[WHViewPager alloc] initWithCatalogs:titles];
        [self.view addSubview:_viewPager];
        
        self.automaticallyAdjustsScrollViewInsets = NO;

    } failure:^(NSError *error) {
        WHLog(@"请求失败：%@",error);
    }];
}

- (void)setUpCatalogViewController
{
    for(int i=0;i<_titleCatalogs.count;){
        NSArray *catalogs = [_titleCatalogs objectForKey:@"catalogs"];
        
        WHCatalogViewController *catalogViewController = [[WHCatalogViewController alloc] initWithCatalog:catalogs];
        [self addChildViewController:catalogViewController];
        
        catalogViewController.view.x = kScreenWidth * i;
        [self.view addSubview:catalogViewController.view];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //present launchViewController only once
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _launchViewController = [[WHLaunchViewController alloc] init];
//        [self presentViewController:_launchViewController animated:NO completion:NULL];
//    });
}
@end
