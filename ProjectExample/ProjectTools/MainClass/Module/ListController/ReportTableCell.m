//
//  ConsultingCell.m
//  HBDemo
//
//  Created by Vols on 2016/10/21.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "ReportTableCell.h"

@interface ReportTableCell ()

@property (nonatomic, strong) UIImageView   * typeImgView;
@property (nonatomic, strong) UILabel       * titleLabel;
@property (nonatomic, strong) UILabel       * detailLabel;

//@property (nonatomic, strong) UILabel       * dateLabel;
//@property (nonatomic, strong) UILabel       * categoryLabel;
//@property (nonatomic, strong) UILabel       * pageLabel;

@end

@implementation ReportTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.typeImgView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];

//        [self.contentView addSubview:self.dateLabel];
//        [self.contentView addSubview:self.categoryLabel];
//        [self.contentView addSubview:self.pageLabel];
        
        [_typeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentView).offset(10);
            make.size.mas_equalTo(CGSizeMake(50, 60));
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.left.equalTo(_typeImgView.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-5);
            make.bottom.equalTo(_detailLabel.mas_top).offset(-10);
        }];
        
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel);
            make.right.equalTo(self.contentView).offset(-20);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.height.mas_equalTo(@30);
        }];
        
        [_titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return self;
}

- (void)setModel:(ReportModel *)model{
    if (_model != model) {
        _model = model;
    }
    
    [self refreshUI:model];
}


- (void)refreshUI:(ReportModel *)model{
    
    if([[[model.DocName pathExtension]lowercaseString]isEqual:@"pdf"]) {
        _typeImgView.image = [UIImage imageNamed:@"pdfpng"];

    }else if ([[[model.DocName pathExtension]lowercaseString]isEqual:@"xls"] || [[[model.DocName pathExtension]lowercaseString]isEqual:@"xlsx"]){
        _typeImgView.image = [UIImage imageNamed:@"excelpng"];
    }
    
    _titleLabel.text = model.DocTitle;
    
    if (_reportCellType == kReportCellTypeList) {
        NSArray * dateArray = [model.DocUploadTime componentsSeparatedByString:@" "];
        _detailLabel.text = [NSString stringWithFormat:@"%@  %@  %d页", dateArray[0], model.PageName, model.DocPages];
    }else if (_reportCellType == kReportCellTypeSearch){
        _detailLabel.text = [NSString stringWithFormat:@"%@", model.DocUploadTime];
    }
}


#pragma mark - getter

- (UIImageView *)typeImgView{
    if (!_typeImgView) {
        _typeImgView = [[UIImageView alloc] init];
    }
    return _typeImgView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:15];
    }
    return _detailLabel;
}

//- (UILabel *)categoryLabel{
//    if (!_categoryLabel) {
//        _categoryLabel = [[UILabel alloc] init];
//        _categoryLabel.textAlignment = NSTextAlignmentCenter;
//        _categoryLabel.font = [UIFont systemFontOfSize:14];
//    }
//    return _categoryLabel;
//}
//
//- (UILabel *)pageLabel{
//    if (!_pageLabel) {
//        _pageLabel = [[UILabel alloc] init];
//        _pageLabel.textAlignment = NSTextAlignmentCenter;
//        _pageLabel.font = [UIFont systemFontOfSize:14];
//    }
//    return _pageLabel;
//}

- (void)layoutSubViews
{
    [super layoutSubviews];
    [self.contentView  layoutIfNeeded];

    self.titleLabel.preferredMaxLayoutWidth = self.titleLabel.bounds.size.width;
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
