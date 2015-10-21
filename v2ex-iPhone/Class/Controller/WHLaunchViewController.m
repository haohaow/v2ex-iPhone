//
//  WHLaunchViewController.m
//  v2ex-iPhone
//
//  Created by hhw on 15/10/21.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import "WHLaunchViewController.h"
#import "WHMacros.h"
#import "WHDataManager.h"
#import <UIImageView+WebCache.h>
@interface WHLaunchViewController ()
@property (nonatomic,weak) UILabel *label;
@property (nonatomic,strong) UIView *snapshotView;
@end

@implementation WHLaunchViewController

- (UIView *)snapshotView
{
    if (_snapshotView == nil) {
        UIView *viewCopy = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self.view]];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:viewCopy];
        viewCopy.frame = window.bounds;
        
        UIGraphicsBeginImageContextWithOptions([UIScreen mainScreen].bounds.size, YES, 0.0);
        [viewCopy.layer renderInContext:UIGraphicsGetCurrentContext()];
        [viewCopy removeFromSuperview];
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _snapshotView = [[UIImageView alloc] initWithImage:img];
        _snapshotView.frame = [UIScreen mainScreen].bounds;
    }
    return _snapshotView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view = [[UINib nibWithNibName:@"LaunchScreen" bundle:nil] instantiateWithOwner:self options:nil].firstObject;
    
    UIApplication *app = [UIApplication sharedApplication];
    [app.keyWindow addSubview:self.snapshotView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@",@"WHLaunchViewController didAppear...");
    [self.snapshotView removeFromSuperview];
    
    /** add show dynamic views code here */
    [self showImageViews];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}

#pragma mark - add dynamic views in launchView

- (void)showImageViews
{
    UIImageView *launchImageView = [[UIImageView alloc] init];
    launchImageView.backgroundColor = WHRandomColor;
    launchImageView.frame = self.view.bounds;
    [self.view addSubview:launchImageView];
    [launchImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.iyoucai.com/information/201510/8C7EC95543E94D1.png"]];
}






























@end
