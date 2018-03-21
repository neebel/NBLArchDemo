//
//  NBLTheme.h
//  NBLArchDemo
//
//  Created by neebel on 2018/3/19.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NBLTheme : NSObject

UIColor * UIColorFromHexARGB(CGFloat alpha, NSInteger hexRGB);
UIColor * UIColorFromHexRGB(NSInteger hexColor);

@end
