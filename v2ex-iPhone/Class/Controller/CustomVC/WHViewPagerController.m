//
//  WHViewPagerController.m
//  v2ex-iPhone
//
//  Created by hhw on 15/10/23.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import "WHViewPagerController.h"
#import "UIView+Extension.h"
#import "WHMacros.h"


#define VCHeight  (kScreenHeight - 64 - _titleView.height - 49)
//头部初始字体
static const CGFloat titleFontSize = 14;

@implementation WHViewPagerController

{
    WHViewPagerHeader *_viewPagerHeader;
    NSArray *_titles;

}

- (void)setDataSource:(id<WHViewPagerDataSource>)dataSource
{
    _dataSource = dataSource;
    [self reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _viewPagerHeader = [[WHViewPagerHeader alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 44)];
    [self.view addSubview:_viewPagerHeader];
}

- (void)reloadData
{
    if([_dataSource respondsToSelector:@selector(titlesInViewPagerHeader:)]){
        _titles = [_dataSource titlesInViewPagerHeader:self];
        [self setupHeaderWithTitles:_titles];
    }
}

- (void)setupHeaderWithTitles:(NSArray *)titles
{
    UIButton *preBtn;
    for(NSString *title in titles){
        UIButton *titleItem = [self titleItemWithTitle:title];
        titleItem.x = CGRectGetMaxX(preBtn.frame);
        [_viewPagerHeader addSubview:titleItem];
        preBtn = titleItem;
    }
}

- (UIButton *)titleItemWithTitle:(NSString *)title
{
    UIButton *titleItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleItem setTitle:title forState:UIControlStateNormal];
    [titleItem sizeToFit];
    [titleItem setTitleColor:WHRandomColor forState:UIControlStateNormal];
    [titleItem setBackgroundColor:WHRandomColor];
    titleItem.titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
    
    return titleItem;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
