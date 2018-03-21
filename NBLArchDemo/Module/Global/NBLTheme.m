//
//  NBLTheme.m
//  NBLArchDemo
//
//  Created by neebel on 2018/3/19.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import "NBLTheme.h"

@implementation NBLTheme

UIColor * UIColorFromHexARGB(CGFloat alpha, NSInteger hexRGB)
{
    return [UIColor colorWithRed:((float)((hexRGB & 0xFF0000) >> 16))/255.0
                           green:((float)((hexRGB & 0xFF00) >> 8))/255.0
                            blue:((float)(hexRGB & 0xFF))/255.0
                           alpha:alpha];
}


UIColor * UIColorFromHexRGB(NSInteger hexRGB)
{
    return UIColorFromHexARGB(1, hexRGB);
}

@end
