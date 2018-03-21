//
//  NBLBaseRequest.m
//  NBLArchDemo
//
//  Created by neebel on 2018/2/1.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import "NBLBaseRequest.h"

@implementation NBLBaseRequest

#pragma mark - Public

- (NSString *)requestUrl
{
    return nil;
}


- (NSDictionary *)requestParameters
{
    return nil;
}


- (NBLRequestMethod)requestMethod
{
    return kNBLRequestMethodPost;//默认是Post
}


- (BOOL)shouldCache
{
    return YES;
}


- (NBLBaseInfo *)parseData:(NBLResponse *)response
{
    return nil;
}


- (void)handleResponse:(NBLResponse *)response
{
    //处理公共错误码，登录态过期等
    
    //由子类解析字典生成model
    NBLBaseInfo *info = [self parseData:response];
    
    //回调结果
    if (self.resultBlock) {
        self.resultBlock(info, response.error);
    }
}

@end
