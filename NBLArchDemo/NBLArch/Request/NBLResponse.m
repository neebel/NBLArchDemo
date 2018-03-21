//
//  NBLResponse.m
//  NBLArchDemo
//
//  Created by neebel on 2018/2/1.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import "NBLResponse.h"
#import "NBLNetworkingDef.h"

NSString * const NBLErrorDomain = @"cn.neebel.domain";

@interface NBLResponse()

@property (nonatomic, strong) id responseObject;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSDictionary *responseDic;

@end

@implementation NBLResponse

- (instancetype)initWithResponse:(NSURLResponse *)response
                  responseObject:(id)responseObject
                           error:(NSError *)error
{
    self = [super init];
    if (self) {
        _responseObject = responseObject;
        if (error) {
            _error = error;
        } else {
            if ([_responseObject isKindOfClass:[NSDictionary class]]) {
                _responseDic = (NSDictionary *)_responseObject;
                NSInteger errorCode = [_responseDic[@"code"] integerValue];
                //用于错误和数据分离
                if (errorCode != 200) {
                    NSString *errorMsg = _responseDic[@"msg"];
                    _error = [NSError errorWithDomain:NBLErrorDomain
                                                 code:errorCode
                                             userInfo:@{NSLocalizedDescriptionKey : errorMsg}];
                }
            }
        }
    }
    
    return self;
}

@end
