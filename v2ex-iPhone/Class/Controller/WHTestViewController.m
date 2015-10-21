//
//  WHTestViewController.m
//  v2ex-iPhone
//
//  Created by hhw on 15/10/20.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import "WHTestViewController.h"
#import "WHMacros.h"
#import "WHDataManager.h"

@implementation WHTestViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = WHRandomColor;
    WHDataManager *manager = [WHDataManager sharedManager];
}

@end
