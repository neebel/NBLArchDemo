//
//  NBLSingleNewsInfo.h
//  NBLArchDemo
//
//  Created by neebel on 2018/3/19.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import "NBLBaseInfo.h"

@interface NBLSingleNewsInfo : NBLBaseInfo

@property (nonatomic, copy) NSString *newsTime;
@property (nonatomic, copy) NSString *newsTitle;
@property (nonatomic, copy) NSString *newsDesc;
@property (nonatomic, copy) NSString *newsUrl;
@property (nonatomic, copy) NSString *picUrl;

- (instancetype)initWithJson:(NSDictionary *)json;

@end
