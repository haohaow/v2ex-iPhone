//
//  WHHotViewController.m
//  v2ex-iPhone
//
//  Created by hhw on 15/10/21.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import "WHTopicViewController.h"
#import "WHDataManager.h"
#import "WHMacros.h"
#import "MJExtension.h"
#import "WHTopicModel.h"
#import "WHTopicCell.h"

static NSString *const cellId = @"cellIdentifier";

@interface WHTopicViewController ()
@property (nonatomic,copy) NSMutableArray *topics;
@end

@implementation WHTopicViewController
{
    UITableView *_tableView;
    NSInteger _page;
}

- (NSMutableArray*)topics
{
    if(!_topics){
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _page = 1;
    [self loadData];
}

#pragma mark - private method
- (void)loadData
{
    [[WHDataManager sharedManager] topicLatestAtPage:_page success:^(NSArray *result) {
        
        NSArray *newTopics = [WHTopicModel objectArrayWithKeyValuesArray:result];
        //将新数据插入到数组最后
        NSRange range = NSMakeRange(self.topics.count, newTopics.count);
        NSIndexSet *indexSet =[NSIndexSet indexSetWithIndexesInRange:range];
        [self.topics insertObjects:newTopics atIndexes:indexSet];
        
        WHLog(@"topicModels:%@",self.topics);
        
        
    } failure:^(NSError *error) {
        WHLog(@"error:%@",error.description);
    }];
}

#pragma mark - tableView datasource & delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WHTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[WHTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}


@end
