//
//  NBLBaseManager.h
//  NBLArchDemo
//
//  Created by neebel on 2018/2/1.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBLNetworkingDef.h"

//子类需要实现
@protocol NBLSubManagerProtocol<NSObject>

- (Class)requestClass;

- (NBLRequestType)requestType;

@end

//调用者需要实现
@protocol NBLManagerProtocol<NSObject>

/**
  供调用者提供可变的请求参数，例如分页加载时的页码（可变的）
  所以有两种提供请求参数的方法
  1.重写NBLBaseRequest的requestParameters
  2.调用者实现externalRequestParameters协议
  方式2的优先级大于方式1
**/
- (NSDictionary *)externalRequestParameters;

- (void)receiveResponse:(NBLBaseInfo *)info error:(NSError *)error fromCache:(BOOL)fromCache;

@end

@interface NBLBaseManager : NSObject

@property (nonatomic, weak) id<NBLManagerProtocol> caller;

- (void)loadRequest;

@end
