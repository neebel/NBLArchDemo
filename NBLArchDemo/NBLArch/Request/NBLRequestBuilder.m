//
//  NBLRequestBuilder.m
//  NBLArchDemo
//
//  Created by neebel on 2018/2/1.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import "NBLRequestBuilder.h"
#import <AFNetworking.h>
#import "NBLConfiguration.h"

@interface NBLRequestBuilder()

@property (nonatomic, strong) AFHTTPRequestSerializer *serializer;

@end

@implementation NBLRequestBuilder

#pragma mark - LifeCycle

+ (instancetype)sharedBuilder
{
    static NBLRequestBuilder *_builder = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _builder = [[self alloc] init];
    });
    
    return _builder;
}

#pragma mark - Getter & Setter

- (AFHTTPRequestSerializer *)serializer
{
    if (!_serializer) {
        _serializer = [AFHTTPRequestSerializer serializer];
        _serializer.timeoutInterval = [NBLConfiguration sharedConfiguration].requestTimeoutInterval;
    }
    
    return _serializer;
}

#pragma mark - Public

- (NSURLRequest *)buildURLRequest:(NBLBaseRequest *)request
{
    NSAssert(request.requestUrl.length > 0, @"request url shuoldn't be nil");
    NSAssert(request.requestMethod >= 1, @"request method incorrent");
    
    NSDictionary *requestParameters = request.externalRequestParameters;
    if (!requestParameters) {
        requestParameters = request.requestParameters;
    }
    
    NSMutableURLRequest *mutableRequest = [self.serializer requestWithMethod:[self methodNameFromRequest:request] URLString:request.requestUrl parameters:requestParameters error:NULL];
    return mutableRequest;
}


- (NSString *)methodNameFromRequest:(NBLBaseRequest *)request
{
    NSString *methodName = nil;
    switch (request.requestMethod) {
        case kNBLRequestMethodGet:
            methodName = @"GET";
            break;
            
        case kNBLRequestMethodPost:
            methodName = @"POST";
            break;
            
        case kNBLRequestMethodHead:
            methodName = @"HEAD";
            break;
        case kNBLRequestMethodDelete:
            methodName = @"DELETE";
            break;
            
        case kNBLRequestMethodPatch:
            methodName = @"PATCH";
            break;
            
        default:
            break;
    }
    
    return methodName;
}

@end
