//
//  NBLNewsInfo.h
//  NBLArchDemo
//
//  Created by neebel on 2018/3/12.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import "NBLBaseInfo.h"
#import "NBLSingleNewsInfo.h"

@interface NBLNewsInfo : NBLBaseInfo

@property (nonatomic, strong) NSArray<NBLSingleNewsInfo *> *newsList;

- (instancetype)initWithJson:(NSDictionary *)json;

@end
