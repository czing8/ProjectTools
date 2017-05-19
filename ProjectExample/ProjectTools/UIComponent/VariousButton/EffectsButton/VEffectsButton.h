//
//  VEffectsButton.h
//  VEffectsButtonDemo
//
//  Created by Vols on 15/7/21.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickHandle)();

@interface VEffectsButton : UIButton

@property (nonatomic, strong) UIColor                   * imageColorOn;
@property (nonatomic, strong) UIColor                   * imageColorOff;
@property (nonatomic, strong) UIColor                   * circleColor;
@property (nonatomic, strong) UIColor                   * lineColor;
@property (nonatomic, assign) double                    duration;
@property(nonatomic,getter=isSelected) BOOL             selected;

@property (nonatomic, copy) ClickHandle clickHandle;


- (id)initWithFrame:(CGRect)frame image:(UIImage *)image;

- (void)select;

- (void)deselect;

- (void)configureViewWithImage:(UIImage *)image;

@end
