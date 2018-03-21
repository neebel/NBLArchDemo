//
//  NBLConfiguration.h
//  NBLArchDemo
//
//  Created by neebel on 2018/2/1.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBLConfiguration : NSObject

+ (instancetype)sharedConfiguration;

@property (nonatomic, assign) NSTimeInterval requestTimeoutInterval;//请求的超时时间

@property (nonatomic, copy) NSString *cacheFileName;//存储响应缓存的文件名

@end
