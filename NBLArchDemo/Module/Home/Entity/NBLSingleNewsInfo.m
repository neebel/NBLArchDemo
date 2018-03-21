//
//  NBLSingleNewsInfo.m
//  NBLArchDemo
//
//  Created by neebel on 2018/3/19.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import "NBLSingleNewsInfo.h"

@implementation NBLSingleNewsInfo

- (instancetype)initWithJson:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        _newsTime = json[@"ctime"];
        _newsTitle = json[@"title"];
        _newsDesc = json[@"description"];
        _newsUrl = json[@"url"];
        _picUrl = json[@"picUrl"];
    }
    
    return self;
}

@end
