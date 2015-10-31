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

@implementation WHViewPagerController
{
    WHViewPagerHeader *_titleView;
    UIScrollView *_scrollView;
}

- (void)setDatasource:(id<WHViewPagerDataSource>)datasource
{
    _datasource = datasource;
    [self reload];
}

- (void)reload
{
    NSInteger viewPagerCounts;
    //numbers of controllers in viewPagerController
    if([_datasource respondsToSelector:@selector(numberOfViewPagerControllers:)]){
        viewPagerCounts = [_datasource numberOfViewPagerControllers:self];
    }

    //set up controllers
    for (int i = 0;i<viewPagerCounts;i++) {
        /** scrollViewController */
        UIViewController *viewController = [[UIViewController alloc] init];
        viewController.view.backgroundColor = WHRandomColor;
        [self addChildViewController:viewController];
        viewController.view.frame = CGRectMake(kScreenWidth * i, 64 + _titleView.height, kScreenWidth, VCHeight);
        [_scrollView addSubview:viewController.view];
        if(i==viewPagerCounts - 1){
            _scrollView.contentSize = CGSizeMake(CGRectGetMaxX(viewController.view.frame), viewController.view.height);
        }
    }
    
    //init & setup titleView
    _titleView = [[WHViewPagerHeader alloc] initWithTitleCount:viewPagerCounts];
    [self.view addSubview:_titleView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if([_datasource respondsToSelector:@selector(viewPagerController:titleAtIndex:)]){
        for(int i = 0;i<viewPagerCounts;i++){
            WHCatalogModel *titleModel = [_datasource viewPagerController:self titleAtIndex:i];
            UIButton *button = [_titleView titleButtonWithTitle:titleModel titleAtIndex:i];
            //最后一个按钮
            if(i==viewPagerCounts - 1){
                _titleView.contentSize = CGSizeMake(CGRectGetMaxX(button.frame), button.height);
            }else if(i == 0){
                UIScrollView *pageIndicator = [[UIScrollView alloc] initWithFrame:button.bounds];
                pageIndicator.backgroundColor = WHRandomColor;
                pageIndicator.alpha = 0.3;
                [_titleView addSubview:pageIndicator];
                _titleView.pageIndicator = pageIndicator;
            }
            
        }
    }
    
    
}

- (void)setupContentViews
{

}

- (void)setupTitleViews
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:_scrollView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    int page = scrollView.contentOffset.x / _scrollView.width + 0.5;
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
