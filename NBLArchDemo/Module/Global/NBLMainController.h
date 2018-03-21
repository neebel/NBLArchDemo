//
//  NBLMainController.h
//  NBLArchDemo
//
//  Created by neebel on 2018/3/11.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NBLMainController : NSObject

//处理全局调度
+ (instancetype)sharedController;

- (UIViewController *)rootViewController;

@end
