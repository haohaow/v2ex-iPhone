//
//  WHHomeOneVC.m
//  v2ex-iPhone
//
//  Created by hhw on 15/11/3.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import "WHHomeOneVC.h"
#import "WHMacros.h"
#import "WHTitleModel.h"
#import "MJExtension.h"
static NSString * const cellId = @"cellId";
@implementation WHHomeOneVC
{
    NSArray *_nodes;
    NSArray *_nodeModels;
}
- (instancetype)initWithNodes:(NSArray *)nodes
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self){
        _nodes = nodes;
        self.view.backgroundColor = WHRandomColor;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _nodeModels = [WHNodeModel objectArrayWithKeyValuesArray:_nodes];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _nodeModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    WHNodeModel *node = _nodeModels[indexPath.row];
    
    WHLog(@"catalog:%@",node);
    cell.textLabel.text = node.label;
    cell.detailTextLabel.text = node.name;
    cell.alpha = 0;
    cell.backgroundColor = nil;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WHNodeModel *node = (WHNodeModel *)_nodeModels[indexPath.row];
    WHLog(@"%@",node.name);
}

@end
