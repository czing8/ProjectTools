//
//  VAnswerCell.m
//  ProjectTools
//
//  Created by Vols on 2016/2/20.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "VAnswerCell.h"

@interface VAnswerCell ()

@property (nonatomic, strong) UITextView   * textView;

@end

@implementation VAnswerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.textView];
        _textView.backgroundColor = [UIColor orangeColor];
        
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 10, 10, 10));
        }];
    }
    return self;
}

- (void)setModel:(VHelpModel *)model{
    if (_model != model) {
        _model = model;
    }
    
    [self refreshUI:model];
}


- (void)refreshUI:(VHelpModel *)model{
    _textView.text = model.answerString;
}

- (void)layoutSubViews {
    [super layoutSubviews];
//    [self.contentView  layoutIfNeeded];
    
}


#pragma mark - getter

- (UITextView *)textView{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
    }
    return _textView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
