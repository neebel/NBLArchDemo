//
//  NBLRequestBuilder.h
//  NBLArchDemo
//
//  Created by neebel on 2018/2/1.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBLBaseRequest.h"

@interface NBLRequestBuilder : NSObject

+ (instancetype)sharedBuilder;

- (NSURLRequest *)buildURLRequest:(NBLBaseRequest *)request;

@end
