//
//  NBLNewsRequest.m
//  NBLArchDemo
//
//  Created by neebel on 2018/3/12.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import "NBLNewsRequest.h"
#import "NBLNewsInfo.h"

@implementation NBLNewsRequest

- (NSString *)requestUrl
{
    return @"http://api.huceo.com/wxnew/";
}


- (NBLRequestMethod)requestMethod
{
    return kNBLRequestMethodGet;
}


- (BOOL)shouldCache
{
    return NO;
}


- (NBLBaseInfo *)parseData:(NBLResponse *)response
{
    NBLNewsInfo *newsInfo = [[NBLNewsInfo alloc] initWithJson:response.responseDic];
    return newsInfo;
}

@end
