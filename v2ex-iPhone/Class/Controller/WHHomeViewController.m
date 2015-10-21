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


@implementation WHHomeViewController
{
    WHLaunchViewController *_launchViewController;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",@"homeViewController didLoad...");
    self.view.backgroundColor = WHRandomColor;

    
//    [[WHDataManager sharedManager] siteInfoSuccess:^(id result) {
//        WHLog(@"请求成功:%@",result);
//    } failure:^(NSError *error) {
//        WHLog(@"请求失败:%@",error);
//    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _launchViewController = [[WHLaunchViewController alloc] init];
    NSLog(@"%@",@"homeViewController viewWillAppear...");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self presentViewController:_launchViewController animated:NO completion:NULL];
    });
}
@end
