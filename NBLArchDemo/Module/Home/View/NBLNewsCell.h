//
//  NBLNewsCell.h
//  NBLArchDemo
//
//  Created by neebel on 2018/3/19.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NBLNewsInfo.h"

@interface NBLNewsCell : UITableViewCell

- (void)updateCellWithInfo:(NBLSingleNewsInfo *)info;

@end
