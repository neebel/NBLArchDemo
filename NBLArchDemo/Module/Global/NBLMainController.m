//
//  NBLMainController.m
//  NBLArchDemo
//
//  Created by neebel on 2018/3/11.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import "NBLMainController.h"
#import "NBLTabBarController.h"

@implementation NBLMainController

#pragma mark - Init

+ (instancetype)sharedController
{
    static NBLMainController *_mainController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mainController = [[self alloc] init];
    });
    
    return _mainController;
}


#pragma mark - Public

- (UIViewController *)rootViewController
{
    //进入登录页还是主页
    if (0) {
        return nil;
    } else {
        return [[NBLTabBarController alloc] init];
    }
}

@end
