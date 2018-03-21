//
//  NBLBaseRequest.h
//  NBLArchDemo
//
//  Created by neebel on 2018/2/1.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBLNetworkingDef.h"
#import "NBLResponse.h"

@interface NBLBaseRequest : NSObject

@property (nonatomic, copy)   NBLResultBlock resultBlock;

//外部（manager）传入的请求参数，优先级高于子类继承提供的请求参数
@property (nonatomic, strong) NSDictionary *externalRequestParameters;

//子类需要继承
- (NSString *)requestUrl;

- (NSDictionary *)requestParameters;

- (NBLRequestMethod)requestMethod;

- (BOOL)shouldCache;

- (NBLBaseInfo *)parseData:(NBLResponse *)response;

//子类忽略此方法
- (void)handleResponse:(NBLResponse *)response;

@end
