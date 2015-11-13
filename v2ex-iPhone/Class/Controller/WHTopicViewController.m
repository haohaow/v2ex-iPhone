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


@interface WHTopicViewController () <UITableViewDataSource,UITableViewDelegate>
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
    _tableView                 = [[UITableView alloc] initWithFrame:self.view.frame];
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    [self.view addSubview:_tableView];
    _page = 1;
    [self loadData];

}

#pragma mark - private method
- (void)loadData
{
    [[WHDataManager sharedManager] topicLatestAtPage:_page success:^(NSArray *result) {
        
        NSMutableArray *newTopics = [NSMutableArray array];

        for (int i=0; i<result.count; i++) {
            WHMemberModel *member = [WHMemberModel objectWithKeyValues:[result[i] objectForKey:@"member"]];
            WHNodeModel *node = [WHNodeModel objectWithKeyValues:[result[i] objectForKey:@"node"]];
            WHTopicModel *topic = [WHTopicModel objectWithKeyValues:result[i]];
            topic.creater = member;
            topic.node = node;
            [newTopics addObject:topic];
        }

        //将新数据插入到数组最后
        NSRange range = NSMakeRange(self.topics.count, newTopics.count);
        NSIndexSet *indexSet =[NSIndexSet indexSetWithIndexesInRange:range];
        [self.topics insertObjects:newTopics atIndexes:indexSet];
        [_tableView reloadData];
        
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
    static NSString *CellIdentifier = @"CellIdentifier";

    WHTopicCell *cell = (WHTopicCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[WHTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.model = self.topics[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WHTopicModel *model = self.topics[indexPath.row];
    return [WHTopicCell heighWithModel:model];
}













@end
