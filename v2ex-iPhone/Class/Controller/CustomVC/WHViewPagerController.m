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
    BOOL _isDraggingLeft;
    NSInteger _pageIndex;
    CGFloat _offsetX;
    UIButton *_currentButton;
    UIButton *_nextButtonOnDragging;
    UIButton *_prevButtonOnDragging;
    BOOL _isDecelerating;
    CGFloat _indicatorX;
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
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    //还原
    _isDecelerating = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    CGPoint ori = [scrollView.panGestureRecognizer velocityInView:scrollView];
//    if(ori.x < 0){
//        _isDraggingLeft = YES;
//    }else if (ori.x > 0){
//        _isDraggingLeft = NO;
//    }
    [self setupButtons];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX =scrollView.contentOffset.x - _offsetX;
//    if(scrollView.contentOffset.x>_offsetX){
//        offsetX = scrollView.contentOffset.x - _offsetX;
//    }else{
//        offsetX = _offsetX - scrollView.contentOffset.x;
//    }
    WHLog(@"%f",offsetX);

    //位移
    CGFloat localOffsetX;
    //放大比例
    double percent;
    CGFloat toButtonWidth;

    if(offsetX > 0){
        localOffsetX = offsetX * (_currentButton.width / _titleView.width);
        toButtonWidth = _nextButtonOnDragging.width;
    }else{
        localOffsetX = offsetX * (_prevButtonOnDragging.width / _titleView.width);
        toButtonWidth = _prevButtonOnDragging.width;
    }

//    percent = fabs(((toButtonWidth - _currentButton.width) / _currentButton.width) * (localOffsetX / _currentButton.width));
    
    WHLog(@"percent:%f",percent);
    
    _titleView.pageIndicator.x = _indicatorX + localOffsetX;
    
    _titleView.pageIndicator.transform = CGAffineTransformMakeScale(1 + percent, 1);
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat offsetX = scrollView.contentOffset.x;
//    //pageIndex on dragging
//    int pageIndex = offsetX / _scrollView.width + 0.5;
//    
//    _currentButton = _titleView.titles[_pageIndex];
//    
//    if(_pageIndex == 0 ){
//        _prevButtonOnDragging = _currentButton;
//    }else{
//        _prevButtonOnDragging = _titleView.titles[_pageIndex - 1];
//    }
//    
//    if(_pageIndex >= _titleView.titles.count){
//        _nextButtonOnDragging = _currentButton;
//    }else{
//        _nextButtonOnDragging = _titleView.titles[_pageIndex + 1];
//    }
//    
//    //indicator还原
//    if(_isDecelerating && _pageIndex==pageIndex){//放手后，还原
//        WHLog(@"decelerating");
//    }else{//拖动时
//        _isDecelerating = NO;
//        //indicator向右边移动
//        if(scrollView.contentOffset.x > _offsetX){
//            WHLog(@"right");
//            _titleView.pageIndicator.x += 5;
//        }
//        //indicator向左边移动
//        else if(scrollView.contentOffset.x < _offsetX){
//            WHLog(@"left");
//        }
//    }
//    
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _offsetX = scrollView.contentOffset.x;
    _isDecelerating = NO;
    
    CGFloat offsetX = scrollView.contentOffset.x;
    //当前页数
    _pageIndex = offsetX / _scrollView.width + 0.5;
    
    [self setupButtons];
    
    //当前indicatorX
    _indicatorX = _currentButton.x;
    
}

- (void)setupButtons
{
    _currentButton = _titleView.titles[_pageIndex];

    if(_pageIndex == 0 ){
        _prevButtonOnDragging = _currentButton;
    }else{
        _prevButtonOnDragging = _titleView.titles[_pageIndex - 1];
    }

    if(_pageIndex >= _titleView.titles.count){
        _nextButtonOnDragging = _currentButton;
    }else{
        _nextButtonOnDragging = _titleView.titles[_pageIndex + 1];
    }
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
