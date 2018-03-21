//
//  NBLNewsCell.m
//  NBLArchDemo
//
//  Created by neebel on 2018/3/19.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import "NBLNewsCell.h"
#import "NBLTheme.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface NBLNewsCell()

@property (nonatomic, strong) UILabel *newsTitleLabel;
@property (nonatomic, strong) UILabel *newsDescLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *picImageView;

@end

@implementation NBLNewsCell

#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.newsTitleLabel];
        __weak typeof(self) weakSelf = self;
        [self.newsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView).with.offset(15);
            make.top.equalTo(weakSelf.contentView).with.offset(12);
            make.right.equalTo(weakSelf.contentView).with.offset(-105);
            make.height.mas_equalTo(60);
        }];
        
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.contentView).with.offset(-12);
            make.right.equalTo(weakSelf.contentView).with.offset(-105);
            make.height.mas_equalTo(16);
            make.width.mas_equalTo(100);
        }];
        
        [self.contentView addSubview:self.newsDescLabel];
        [self.newsDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView).with.offset(15);
            make.bottom.equalTo(weakSelf.contentView).with.offset(-12);
            make.height.mas_equalTo(16);
            make.right.equalTo(weakSelf.timeLabel.mas_left).with.offset(-10);
        }];
        
        [self.contentView addSubview:self.picImageView];
        [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(60);
            make.right.equalTo(weakSelf.contentView).with.offset(-15);
            make.centerY.equalTo(weakSelf.contentView);
        }];
    }
    
    return self;
}

#pragma mark - Getter

- (UILabel *)newsTitleLabel
{
    if (!_newsTitleLabel) {
        _newsTitleLabel = [[UILabel alloc] init];
        _newsTitleLabel.font = [UIFont systemFontOfSize:18];
        _newsTitleLabel.numberOfLines = 2;
        _newsTitleLabel.textColor = UIColorFromHexRGB(0x333333);
    }
    
    return _newsTitleLabel;
}


- (UILabel *)newsDescLabel
{
    if (!_newsDescLabel) {
        _newsDescLabel = [[UILabel alloc] init];
        _newsDescLabel.font = [UIFont systemFontOfSize:12];
        _newsDescLabel.textColor = UIColorFromHexRGB(0x999999);
    }
    
    return _newsDescLabel;
}


- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = UIColorFromHexRGB(0x999999);
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _timeLabel;
}


- (UIImageView *)picImageView
{
    if (!_picImageView) {
        _picImageView = [[UIImageView alloc] init];
        _picImageView.backgroundColor = UIColorFromHexRGB(0x999999);
        _picImageView.contentMode = UIViewContentModeScaleAspectFill;
        _picImageView.clipsToBounds = YES;
    }
    
    return _picImageView;
}

#pragma mark - Public

- (void)updateCellWithInfo:(NBLSingleNewsInfo *)info
{
    self.newsTitleLabel.text = info.newsTitle;
    self.newsDescLabel.text = info.newsDesc;
    self.timeLabel.text = info.newsTime;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:info.picUrl]];
}

@end
