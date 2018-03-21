//
//  NBLNetworkingDef.h
//  NBLArchDemo
//
//  Created by neebel on 2018/2/1.
//  Copyright © 2018年 neebel. All rights reserved.
//

#ifndef NBLNetworkingDef_h
#define NBLNetworkingDef_h
#import "NBLBaseInfo.h"

typedef NS_ENUM(NSUInteger, NBLRequestMethod){
    kNBLRequestMethodGet = 1,
    kNBLRequestMethodPost,
    kNBLRequestMethodHead,
    kNBLRequestMethodPut,
    kNBLRequestMethodDelete,
    kNBLRequestMethodPatch
};

typedef NS_ENUM(NSUInteger, NBLRequestType){
    NBLRequestTypeFromCache = 1, //加载缓存数据
    NBLRequestTypeFromNetwork,   //忽略缓存直接加载网络数据
    NBLRequestTypeFromCacheAndNetwork//先加载缓存后加载网络数据
};

typedef void(^NBLResultBlock)(NBLBaseInfo *info, NSError *error);

#endif /* NBLNetworkingDef_h */
