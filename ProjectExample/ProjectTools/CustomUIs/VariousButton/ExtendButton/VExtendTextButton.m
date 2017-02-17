//
//  VExtendTextButton.m
//  TextExtendButton
//
//  Created by Vols on 15/3/18.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "VExtendTextButton.h"

#define ICON_WH                           (16.0)
#define ICON_TITLE_MARGIN                 (8.0)

@implementation VExtendTextButton

- (id)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"从文件加载TitleButton");
    if (self = [super initWithCoder:aDecoder]) {
        [self initializeButton];
    }

    return self;
}

/** 从代码中加载对象就会调用此方法 */
- (instancetype)initWithFrame:(CGRect)frame {
    NSLog(@"从代码加载TitleButton");
    if (self = [super initWithFrame:frame]) {
        [self initializeButton];
    }
    
    return self;
}

- (void) initializeButton {
    // 设置font
//    self.titleFont = [UIFont systemFontOfSize:14]; // 暂时先自定义font
//    self.titleLabel.font = self.titleFont;
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    // 图标居中
    [self.imageView setContentMode:UIViewContentModeCenter];
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, (CGRectGetHeight(contentRect) - ICON_WH)/2.0, ICON_WH, ICON_WH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(ICON_WH + ICON_TITLE_MARGIN, 0,
                      CGRectGetWidth(contentRect) - ICON_WH - ICON_WH,
                      CGRectGetHeight(contentRect));
}

@end
