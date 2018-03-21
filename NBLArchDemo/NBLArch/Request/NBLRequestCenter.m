//
//  NBLRequestCenter.m
//  NBLArchDemo
//
//  Created by neebel on 2018/2/1.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import "NBLRequestCenter.h"
#import <AFNetworking.h>
#import "NBLRequestBuilder.h"

@interface NBLRequestCenter()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) dispatch_queue_t     requestQueue;

@end

@implementation NBLRequestCenter

#pragma mark - LifeCycle

+ (instancetype)sharedCenter
{
    static NBLRequestCenter *_center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _center = [[self alloc] init];
    });
    
    return _center;
}

#pragma mark - Getter & Setter

- (AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.securityPolicy.allowInvalidCertificates = YES;
        _sessionManager.securityPolicy.validatesDomainName = NO;
    }
    
    return _sessionManager;
}


- (dispatch_queue_t)requestQueue
{
    if (!_requestQueue) {
        _requestQueue = dispatch_queue_create("cn.neebel.arch.request", DISPATCH_QUEUE_SERIAL);
    }
    
    return _requestQueue;
}

#pragma mark - Public

- (void)sendRequest:(NBLBaseRequest *)request
{
    dispatch_async(self.requestQueue, ^{
        NSURLRequest *urlRequest = [[NBLRequestBuilder sharedBuilder] buildURLRequest:request];
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        __weak typeof(self) weakSelf = self;
        NSURLSessionDataTask *dataTask = [self.sessionManager dataTaskWithRequest:urlRequest
                                                                completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                                    __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                    [strongSelf handleResponse:response responseObject:responseObject error:error request:request];
                                                                }];
#pragma clang diagnostic pop
        [dataTask resume];
    });
}

#pragma mark - Private

- (void)handleResponse:(NSURLResponse *)response responseObject:(id)responseObject error:(NSError *)error request:(NBLBaseRequest *)request
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NBLResponse *result = [[NBLResponse alloc] initWithResponse:response responseObject:responseObject error:error];
        [request handleResponse:result];
    });
}

@end
