//
//  VHelpHeaderView.m
//  ProjectTools
//
//  Created by Vols on 2016/2/20.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "VHelpHeaderView.h"

@interface VHelpHeaderView() {
    UIButton *_bgButton;
    UILabel *_numLabel;
}

@end

@implementation VHelpHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    static NSString *headIdentifier = @"VHelpHeaderView";
    
    VHelpHeaderView *headView;
    if (headView == nil) {
        headView = [[VHelpHeaderView alloc] initWithReuseIdentifier:headIdentifier];
    }
    
    return headView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [bgButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [bgButton setTitleColor:[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1] forState:UIControlStateNormal];
        bgButton.titleLabel.font = [UIFont systemFontOfSize:16];
        bgButton.imageView.contentMode = UIViewContentModeCenter;
        bgButton.imageView.clipsToBounds = NO;
        bgButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        bgButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        //        bgButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        bgButton.contentEdgeInsets = UIEdgeInsetsMake(30, SCREEN_WIDTH-30, 30, 0);
        bgButton.titleEdgeInsets = UIEdgeInsetsMake(0, -SCREEN_WIDTH+30, 0, 50);
        [bgButton addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgButton];
        _bgButton = bgButton;
        
    }
    return self;
}

- (void)headBtnClick {
    _helpModel.opened = !_helpModel.isOpened;
    if (self.clickHandler) {
        self.clickHandler();
    }
}

- (void)setHelpModel:(VHelpModel *)helpModel {
    _helpModel = helpModel;
    [_bgButton setTitle:_helpModel.questionString forState:UIControlStateNormal];
}

- (void)didMoveToSuperview {
    _bgButton.imageView.transform = _helpModel.isOpened ? CGAffineTransformMakeRotation(M_PI_2*2) : CGAffineTransformMakeRotation(0);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _bgButton.frame = self.bounds;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
}


@end
