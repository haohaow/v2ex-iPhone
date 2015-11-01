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

@interface WHViewPagerController ()
@property (nonatomic,copy) NSMutableArray *titleItems;
@end

@implementation WHViewPagerController

{
    UIScrollView *_titleHeaderView;
    UIImageView *_indicator;
    NSArray *_titles;
    UIScrollView *_contentView;

}

- (NSMutableArray *)titleItems
{
    if(!_titleItems){
        _titleItems = [NSMutableArray array];
    }
    return _titleItems;
}

- (void)setDataSource:(id<WHViewPagerDataSource>)dataSource
{
    _dataSource = dataSource;
    [self reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _titleHeaderView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 44)];
    [self.view addSubview:_titleHeaderView];
    
    _indicator = [[UIImageView alloc] initWithFrame:CGRectMake(0, _titleHeaderView.height - 2 + 64, 30, 2)];
    _indicator.backgroundColor = WHRandomColor;
    [self.view addSubview:_indicator];
    
    _contentView = [[UIScrollView alloc] init];
    [self.view addSubview:_contentView];
}

- (void)reloadData
{
    if([_dataSource respondsToSelector:@selector(titlesInViewPagerHeader:)]){
        _titles = [_dataSource titlesInViewPagerHeader:self];

        [self setupHeaderViewWithTitles:_titles];

        [self setupContentVCWithTitleCount:_titles.count];
    }
}

//设置头部标题
- (void)setupHeaderViewWithTitles:(NSArray *)titles
{
    UIButton *preBtn;
    
    for(NSString *title in titles){
        UIButton *titleItem = [self titleItemWithTitle:title];
        titleItem.x = CGRectGetMaxX(preBtn.frame);
        [_titleHeaderView addSubview:titleItem];
        preBtn = titleItem;

        [_titleItems addObject:titleItem];
    }
    
    /** 设置标题头部contentSize */
    _titleHeaderView.contentSize = CGSizeMake(CGRectGetMaxX(preBtn.frame), 0);
    _titleHeaderView.bounces = NO;
    _titleHeaderView.showsHorizontalScrollIndicator = NO;
    
   
}

//设置contentVC
- (void)setupContentVCWithTitleCount:(NSInteger)titleCount
{
    UIViewController *preVc;
    for(int i =0;i<titleCount;i++){
        UITableViewController *vc = [[UITableViewController alloc] init];
        vc.view.frame = CGRectMake(CGRectGetMaxX(preVc.view.frame), 0, kScreenWidth, kScreenHeight - 64 - _titleHeaderView.height);
        vc.view.backgroundColor = WHRandomColor;
        [_contentView addSubview:vc.view];
        [self addChildViewController:vc];
        preVc = vc;
        
    }
    WHLog(@"preVc:%@",NSStringFromCGRect(preVc.view.frame));
    _contentView.frame = CGRectMake(0, 64 + _titleHeaderView.height, kScreenWidth, kScreenHeight - 64 - _titleHeaderView.height);
    _contentView.contentSize = CGSizeMake(CGRectGetMaxX(preVc.view.frame), 0);
    _contentView.bounces = NO;
    preVc = nil;
}

- (UIButton *)titleItemWithTitle:(NSString *)title
{
    UIButton *titleItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleItem setTitleColor:WHRandomColor forState:UIControlStateNormal];
    [titleItem setBackgroundColor:WHRandomColor];
    titleItem.titleLabel.font = [UIFont systemFontOfSize:titleFontSize];

    titleItem.contentEdgeInsets = UIEdgeInsetsMake(20, 15, 20, 15);
    [titleItem setTitle:title forState:UIControlStateNormal];

    [titleItem sizeToFit];
    titleItem.height = _titleHeaderView.height;
    
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
