//
//  NBLNewsManager.m
//  NBLArchDemo
//
//  Created by neebel on 2018/3/12.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import "NBLNewsManager.h"
#import "NBLNewsRequest.h"

@implementation NBLNewsManager

- (Class)requestClass
{
    return [NBLNewsRequest class];
}


- (NBLRequestType)requestType
{
    return NBLRequestTypeFromNetwork;
}

@end
