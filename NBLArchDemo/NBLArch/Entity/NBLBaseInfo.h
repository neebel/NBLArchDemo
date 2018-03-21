//
//  NBLBaseInfo.h
//  NBLArchDemo
//
//  Created by neebel on 2018/3/8.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBLBaseInfo : NSObject<NSSecureCoding>

//coding

+ (NSDictionary *)codableProperties;
- (void)setWithCoder:(NSCoder *)aDecoder;

//property access

- (NSDictionary *)codableProperties;
- (NSDictionary *)dictionaryRepresentation;

//loading / saving

+ (instancetype)objectWithContentsOfFile:(NSString *)path;
- (BOOL)writeToFile:(NSString *)filePath atomically:(BOOL)useAuxiliaryFile;

@end
