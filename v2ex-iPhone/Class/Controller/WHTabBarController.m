//
//  WHTabBarController.m
//  
//
//  Created by hhw on 15/11/13.
//
//

#import "WHTabBarController.h"

#import "WHMainPageViewController.h"
#import "WHTopicViewController.h"
#import "WHFocusViewController.h"
#import "WHProfileViewController.h"
#import "WHMacros.h"

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

@implementation WHTabBarController

- (void)viewDidLoad
{
    //初始化子控制器
    WHTopicViewController *topic = [[WHTopicViewController alloc] init];
    [self addChildVc:topic title:@"最新" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
//    WHMainPageViewController *mainPage = [[WHMainPageViewController alloc] init];
//    [self addChildVc:mainPage title:@"版块" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
//    WHFocusViewController *focus = [[WHFocusViewController alloc] init];
//    [self addChildVc:focus title:@"我的关注" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
//    
//    WHProfileViewController *profile = [[WHProfileViewController alloc] init];
//    [self addChildVc:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    if (iOS7) {
        childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = WHColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}

@end
