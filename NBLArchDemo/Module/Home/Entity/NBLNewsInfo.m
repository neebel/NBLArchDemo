//
//  NBLNewsInfo.m
//  NBLArchDemo
//
//  Created by neebel on 2018/3/12.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import "NBLNewsInfo.h"

@implementation NBLNewsInfo

- (instancetype)initWithJson:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        NSArray *newsArr = json[@"newslist"];
        NSMutableArray *newsList = [NSMutableArray array];
        for (NSDictionary *newsDic in newsArr) {
            NBLSingleNewsInfo *newsInfo = [[NBLSingleNewsInfo alloc] initWithJson:newsDic];
            [newsList addObject:newsInfo];
        }
        
        self.newsList = newsList;
    }
    
    return self;
}

@end
