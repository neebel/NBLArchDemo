//
//  NBLConfiguration.m
//  NBLArchDemo
//
//  Created by neebel on 2018/2/1.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import "NBLConfiguration.h"

@implementation NBLConfiguration

#pragma mark - LifeCycle

+ (instancetype)sharedConfiguration
{
    static NBLConfiguration *_configuration = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _configuration = [[self alloc] init];
    });
    
    return _configuration;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _requestTimeoutInterval = 15;
        _cacheFileName = @"responseCache";
    }
    
    return self;
}

@end
