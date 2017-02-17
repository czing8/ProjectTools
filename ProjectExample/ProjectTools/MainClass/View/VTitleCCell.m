//
//  VTitleCCell.m
//  ProjectTools
//
//  Created by Vols on 2016/2/16.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "VTitleCCell.h"
#import <Masonry.h>

@implementation VTitleCCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        UIView * bgView = [UIView new];
        bgView.backgroundColor = [UIColor purpleColor];
        bgView.layer.cornerRadius = 3;
        
        [self.contentView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    __weak typeof(self) weakSelf = self;
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.contentView);
//        make.left.equalTo(weakSelf.contentView);
//        make.width.greaterThanOrEqualTo(@0.1);
//        make.height.greaterThanOrEqualTo(@0.1);
//        make.height.equalTo(weakSelf.contentView).priorityLow();
//    }];
}


#pragma mark - Properties

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

@end
