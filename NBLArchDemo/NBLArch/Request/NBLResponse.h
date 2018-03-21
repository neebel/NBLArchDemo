//
//  NBLResponse.h
//  NBLArchDemo
//
//  Created by neebel on 2018/2/1.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const NBLErrorDomain;

@interface NBLResponse : NSObject

@property (nonatomic, strong, readonly) id responseObject;//原始数据
@property (nonatomic, strong, readonly) NSError *error;
@property (nonatomic, strong, readonly) NSDictionary *responseDic;

- (instancetype)initWithResponse:(NSURLResponse *)response
                  responseObject:(id)responseObject
                           error:(NSError *)error;

@end
