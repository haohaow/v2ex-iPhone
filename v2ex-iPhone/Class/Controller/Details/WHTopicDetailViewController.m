//
//  WHTopicDetailViewController.m
//  v2ex-iPhone
//
//  Created by hhw on 15/11/16.
//  Copyright © 2015年 wuhao. All rights reserved.
//

#import "WHTopicDetailViewController.h"
#import "WHMacros.h"
#import "UIBarButtonItem+Extension.h"

static NSString * const cellId = @"cellId";

@interface WHTopicDetailViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,copy) NSMutableArray *replies;
@end

@implementation WHTopicDetailViewController
{
    UITableView *_tableView;
}

- (NSMutableArray *)replies
{
    if(!_replies){
        _replies = [NSMutableArray array];
    }
    return _replies;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.model.title;
    
    [self setUpTableView];
    
    [self setupNav];
}

- (void)setUpTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView reloadData];

}

-(void)setupNav
{
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithImage:nil handler:^(id sender) {
        WHLog(@"分享菜单");
    }];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - tableView dataSource & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}












@end
