//
//  AppDelegate.m
//  v2ex-iPhone
//
//  Created by hhw on 15/10/20.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import "AppDelegate.h"
#import "WHMacros.h"
#import "WHMainPageViewController.h"
#import "WHTopicViewController.h"
#import "WHFocusViewController.h"
#import "WHProfileViewController.h"
#import "WHTitleModel.h"
#import "MJExtension.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
{
//    NSDictionary *_titleCatalogs;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    [self.window makeKeyAndVisible];
    
    //    [[WHDataManager sharedManager] titleCatalogsSuccess:^(NSArray *result) {
    //        WHLog(@"成功：%@",result);
    //        NSMutableArray *titles = [NSMutableArray array];
    //        for(WHCatalogModel *catalog in result){
    //            NSString *catalogLabel = catalog.catalogLabel;
    //            [titles addObject:catalogLabel];
    //        }
    //
    //        _viewPager = [[WHViewPager alloc] initWithCatalogs:titles];
    //        [self.view addSubview:_viewPager];
    //
    //        self.automaticallyAdjustsScrollViewInsets = NO;
    //
    //    } failure:^(NSError *error) {
    //        WHLog(@"请求失败：%@",error);
    //    }];
    
    
    //Hot
    WHTopicViewController *hotTopic = [[WHTopicViewController alloc] init];
    hotTopic.title = @"热门";
    UINavigationController *hotTopicNav = [[UINavigationController alloc] initWithRootViewController:hotTopic];
    //版块
    WHMainPageViewController *mainPage = [[WHMainPageViewController alloc] init];
    mainPage.title = @"版块";
    UINavigationController *mainPageNav = [[UINavigationController alloc] initWithRootViewController:mainPage];
    //关注
    WHFocusViewController *focus = [[WHFocusViewController alloc] init];
    focus.title = @"我的关注";
    UINavigationController *focusNav = [[UINavigationController alloc] initWithRootViewController:focus];
    //我
    WHProfileViewController *profile = [[WHProfileViewController alloc] init];
    profile.title = @"我";
    UINavigationController *profileNav = [[UINavigationController alloc] initWithRootViewController:profile];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[mainPageNav,hotTopicNav,focusNav,profileNav];
    
    self.window.rootViewController = tabBarController;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
