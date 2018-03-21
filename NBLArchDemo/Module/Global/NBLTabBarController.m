//
//  NBLTabBarController.m
//  NBLArchDemo
//
//  Created by neebel on 2018/3/11.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import "NBLTabBarController.h"
#import "NBLBaseNavigationController.h"
#import "NBLHomeViewController.h"
#import "NBLJokeViewController.h"
#import "NBLBeautyViewController.h"

@interface NBLTabBarController ()

@end

@implementation NBLTabBarController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewControllers = @[[self homeNav], [self jokeNav], [self beautyNav]];
}


- (NBLBaseNavigationController *)homeNav
{
    NBLHomeViewController *homeVC = [[NBLHomeViewController alloc] init];
    homeVC.title = @"新闻";
    homeVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_news"];
    homeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_news"];
    NBLBaseNavigationController *homeNav = [[NBLBaseNavigationController alloc] initWithRootViewController:homeVC];
    return homeNav;
}


- (NBLBaseNavigationController *)jokeNav
{
    NBLJokeViewController *jokeVC = [[NBLJokeViewController alloc] init];
    jokeVC.title = @"笑话";
    jokeVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_joke"];
    jokeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_joke"];
    NBLBaseNavigationController *jokeNav = [[NBLBaseNavigationController alloc] initWithRootViewController:jokeVC];
    return jokeNav;
}


- (NBLBaseNavigationController *)beautyNav
{
    NBLBeautyViewController *beautyVC = [[NBLBeautyViewController alloc] init];
    beautyVC.title = @"美女";
    beautyVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_beauty"];
    beautyVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_beauty"];
    NBLBaseNavigationController *beautyNav = [[NBLBaseNavigationController alloc] initWithRootViewController:beautyVC];
    return beautyNav;
}

@end
