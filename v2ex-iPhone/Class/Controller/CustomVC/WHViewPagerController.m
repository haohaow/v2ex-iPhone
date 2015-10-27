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
    WHViewPager *_titleView;
    UIScrollView *_scrollView;
    UIPageViewController *_pageViewController;
    NSInteger _currentPage;
    CGFloat _scrollViewContentOffSetX;
    CGFloat _originWidth;
    BOOL _isDraggingLeft;
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
    _titleView = [[WHViewPager alloc] initWithTitleCount:viewPagerCounts];
    [self.view addSubview:_titleView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if([_datasource respondsToSelector:@selector(viewPagerController:titleAtIndex:)]){
        for(int i = 0;i<viewPagerCounts;i++){
            WHCatalogModel *titleModel = [_datasource viewPagerController:self titleAtIndex:i];

            if(i==viewPagerCounts -1){
                UIButton *lastTitleButton = [_titleView titleButtonWithTitle:titleModel titleAtIndex:i];
                _titleView.contentSize = CGSizeMake(CGRectGetMaxX(lastTitleButton.frame), lastTitleButton.height);
            }else {
                [_titleView titleButtonWithTitle:titleModel titleAtIndex:i];
            }
            
        }

    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;

    [self.view addSubview:_scrollView];
    
    _originWidth = 50;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    WHLog(@"scrollViewWillBeginDragging");
    CGPoint ori = [scrollView.panGestureRecognizer velocityInView:scrollView];
    if(ori.x < 0){
        _isDraggingLeft = NO;
    }else if (ori.x > 0){
        _isDraggingLeft = YES;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //在屏幕上活动的速度
    CGPoint ori = [scrollView.panGestureRecognizer velocityInView:scrollView];
    
    CGFloat offsetX = scrollView.contentOffset.x;
    int pageIndex = offsetX / _scrollView.width + 0.5;
    NSArray *titles = _titleView.titles;
    WHLog(@"当前页数：%zi",pageIndex);
    UIButton *nextButton = titles[pageIndex];
    //右滑
    if(!_isDraggingLeft &&  pageIndex<titles.count){
        WHLog(@"right");
    }
    //左滑
    else if(_isDraggingLeft && pageIndex>0){
        WHLog(@"left");
    }
    //复位
    else{

    }
    _titleView.pageIndicator.x = nextButton.x;

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    WHLog(@"scrollViewDidEndDecelerating");
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
