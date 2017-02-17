//
//  HistoryCell.m
//  ProjectTools
//
//  Created by Vols on 2016/2/13.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "VHistoryCell.h"

@interface VHistoryCell ()

@property (nonatomic, strong) UILabel * stockNameLabel;
@property (nonatomic, strong) UILabel * stockCodeLabel;
@property (nonatomic, strong) UILabel * stockAttributeLabel;

@end

@implementation VHistoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.stockCodeLabel];
        [self.contentView addSubview:self.stockNameLabel];
        [self.contentView addSubview:self.handleBtn];
        
        [_stockNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(18);
            make.width.equalTo(self.contentView).multipliedBy(0.25);
        }];
        
        [_stockCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(self.contentView);
            make.left.equalTo(_stockNameLabel.mas_right);
            make.width.equalTo(self.contentView).multipliedBy(0.25);
        }];
        
        [_handleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_handleBtn.superview);
            make.right.mas_equalTo(@(-20));
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
    }
    return self;
}

- (void)setModel:(StockModel *)model{
    if (_model != model) {
        _model = model;
    }
    
    [self refreshUI:model];
}

- (void)refreshUI:(StockModel *)model{
    _stockCodeLabel.text = model.stockCode;
    _stockNameLabel.text = model.stockName;
    _handleBtn.selected = model.isSelect;
}

#pragma mark - actions

- (void)clickAction:(UIButton *)sender {
    
    if (sender.selected == NO) {
        sender.selected = YES;
        
        if (self.clickHandler)  self.clickHandler();
    }
}

#pragma mark - Properties

- (UILabel *)stockNameLabel {
    if (_stockNameLabel == nil) {
        _stockNameLabel = [[UILabel alloc] init];
        _stockNameLabel.textAlignment = NSTextAlignmentLeft;
        _stockNameLabel.font = [UIFont systemFontOfSize:16];
    }
    return _stockNameLabel;
}

- (UILabel *)stockCodeLabel {
    if (_stockCodeLabel == nil) {
        _stockCodeLabel = [[UILabel alloc] init];
        _stockCodeLabel.textAlignment = NSTextAlignmentLeft;
        _stockCodeLabel.font = [UIFont systemFontOfSize:16];
    }
    return _stockCodeLabel;
}

- (UIButton *)handleBtn {
    if (_handleBtn == nil) {
        _handleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_handleBtn setImage:[UIImage imageNamed:@"stock_normal"] forState:UIControlStateNormal];
        [_handleBtn setImage:[UIImage imageNamed:@"stock_selected"] forState:UIControlStateSelected];
        [_handleBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _handleBtn;
}

- (void)setIsStockSelected:(BOOL)isStockSelected {
    _isStockSelected = isStockSelected;
    
    _handleBtn.selected = isStockSelected;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
