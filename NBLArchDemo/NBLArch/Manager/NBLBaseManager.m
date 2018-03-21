//
//  NBLBaseManager.m
//  NBLArchDemo
//
//  Created by neebel on 2018/2/1.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import "NBLBaseManager.h"
#import "NBLBaseRequest.h"
#import "NBLRequestCenter.h"
#import "NBLConfiguration.h"
#import <YYCache.h>

@interface NBLBaseManager()

@property (nonatomic, weak) id<NBLSubManagerProtocol> child;

@property (nonatomic, strong) YYCache *yyCache;

@end

@implementation NBLBaseManager

#pragma mark - LifeCycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.child = (id<NBLSubManagerProtocol>)self;
        
        if (![self respondsToSelector:@selector(requestClass)]) {
            NSException *exception = [NSException exceptionWithName:@"NBLBaseManager"
                                                             reason:@"subclass not implement requestClass"
                                                           userInfo:nil];
            @throw exception;
        }
        
        if (![self respondsToSelector:@selector(requestType)]) {
            NSException *exception = [NSException exceptionWithName:@"NBLBaseManager"
                                                             reason:@"subclass not implement requestType"
                                                           userInfo:nil];
            @throw exception;
        }
    }
    
    return self;
}

#pragma mark - Getter

- (YYCache *)yyCache
{
    if (!_yyCache) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachePath = [paths objectAtIndex:0];
        NSString *fullPath = [cachePath stringByAppendingPathComponent:[NBLConfiguration sharedConfiguration].cacheFileName];
        _yyCache = [[YYCache alloc] initWithPath:fullPath];
    }
    
    return _yyCache;
}

#pragma mark - Public

- (void)loadRequest
{
    NBLRequestType requestType = [self.child requestType];
    switch (requestType) {
        case NBLRequestTypeFromCache:
            [self loadFromCache];
            break;
            
        case NBLRequestTypeFromNetwork:
            [self loadFromNetwork];
            break;
            
        case NBLRequestTypeFromCacheAndNetwork:
            [self loadFromCacheAndNetwork];
            break;
            
        default:
            [self loadFromCacheAndNetwork];
            break;
    }
}

#pragma mark - Private

//加载缓存数据
- (void)loadFromCache
{
    id request = [[[self.child requestClass] alloc] init];
    if ([request isKindOfClass:[NBLBaseRequest class]]) {
        NBLBaseRequest *baseRequest = (NBLBaseRequest *)request;
        __weak typeof(self) weakSelf = self;
        [self.yyCache objectForKey:NSStringFromClass([baseRequest class]) withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
            id info = object;
            if ([info isKindOfClass:[NBLBaseInfo class]]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([weakSelf.caller respondsToSelector:@selector(receiveResponse: error: fromCache:)]) {
                        [weakSelf.caller receiveResponse:(NBLBaseInfo *)info error:nil fromCache:YES];
                    }
                });
            }
        }];
    }
}


//加载网络数据
- (void)loadFromNetwork
{
    id request = [[[self.child requestClass] alloc] init];
    if ([request isKindOfClass:[NBLBaseRequest class]]) {
        NBLBaseRequest *baseRequest = (NBLBaseRequest *)request;
        if ([self.caller respondsToSelector:@selector(externalRequestParameters)]) {
            baseRequest.externalRequestParameters = [self.caller externalRequestParameters];
        }
        
        __weak typeof(self) weakSelf = self;
        __weak typeof(baseRequest) weakRequest = baseRequest;
        baseRequest.resultBlock = ^(NBLBaseInfo *info, NSError *error) {
            if (!weakSelf || !weakRequest) {
                return;
            }
            
            if (!error && info && [weakRequest shouldCache]) {
                //异步更新缓存
                [weakSelf.yyCache setObject:info forKey:NSStringFromClass([weakRequest class]) withBlock:^{
                    
                }];
            }
            
            if ([weakSelf.caller respondsToSelector:@selector(receiveResponse: error: fromCache:)]) {
                [weakSelf.caller receiveResponse:info error:error fromCache:NO];
            }
        };
        
        [[NBLRequestCenter sharedCenter] sendRequest:baseRequest];
    }
}


//先加载缓存，后加载网络数据
- (void)loadFromCacheAndNetwork
{
    [self loadFromCache];
    [self loadFromNetwork];
}

@end
